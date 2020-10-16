SPOOL UTLBFILE.LOG
-- UTLBFILE.SQL
--
-- FileOperations Java class PL/SQL wrapper package
-- for reading and writing OS files to/from BLOBs
-- Also supports listing and reading files in ZIP or JAR archives
-- and data compression
--
-- Copyright(c) 2002-2004 by Vladimir M. Zakharychev
-- All rights reserved.
-- Written by Vladimir M. Zakharychev
--
-- Requirements:
--  - Oracle8i Release 2 (8.1.6) or later 
--  - Java VM (JServer/Oracle VM) installed into the RDBMS and functional
--  - FileOps.jar loaded with public synonyms and grants (-g public -s)
--

-- create necessary objects and synonyms for directory listing procedure
-- and grant necessary rights for objects to PUBLIC

DROP PUBLIC SYNONYM NN$FOPS$DIR_LIST
/
DROP PUBLIC SYNONYM UTL_BinFile
/
DROP TABLE NN$FOPS$DIR_LIST
/
CREATE GLOBAL TEMPORARY TABLE NN$FOPS$DIR_LIST ( FILENAME VARCHAR2(1024),
                                                 FILETYPE VARCHAR2(4),
                                                 FILESIZE NUMBER(12,0),
                                                 MTIME    DATE)
 ON COMMIT DELETE ROWS
/

COMMENT ON TABLE NN$FOPS$DIR_LIST IS 
'Temporary table that receives directory/ZIP archive listings from UTL_BINFILE.
Public synonym is created for this table and DML grants (SELECT, INSERT, DELETE) are given to PUBLIC';
COMMENT ON COLUMN NN$FOPS$DIR_LIST.FILENAME IS 'Name of the file (for ZIPs - including full path from archive root)';
COMMENT ON COLUMN NN$FOPS$DIR_LIST.FILETYPE IS 'DIR or FILE (directory or regular file respectively)';
COMMENT ON COLUMN NN$FOPS$DIR_LIST.FILESIZE IS 'Size of the file (0 for directories) or -1 if not known (usually for ZIP/JAR directory entries)';
COMMENT ON COLUMN NN$FOPS$DIR_LIST.MTIME    IS 'File modification timestamp';

CREATE PUBLIC SYNONYM NN$FOPS$DIR_LIST FOR NN$FOPS$DIR_LIST
/
GRANT INSERT, DELETE, SELECT ON NN$FOPS$DIR_LIST TO PUBLIC
/

CREATE OR REPLACE PACKAGE UTL_BinFile
AUTHID CURRENT_USER -- DO NOT REMOVE THIS LINE!!!
AS
/*
   UTL_BinFile						    Version 1.0.7.017
   --------------------------------------------------------------------------

   Utility package for manipulating binary OS/Internal LOB files/archives.

   Copyright(c) 2002-2004 by Vladimir M. Zakharychev.
   All rights reserved.
   Written by Vladimir M. Zakharychev (bob@dynamicpsp.com)

   Hit-Media website can be reached at http://www.dynamicpsp.com

   This package REQUIRES com.nnetworks.FileOperations Java class.
   Correct java.io.FilePermission permissions MUST be granted to the invoker
   of the package with DBMS_JAVA.GRANT_PERMISSION() for the package to be
   able to list, read and/or write OS files in particular directories, including
   ZIP/JAR archives stored in the file system. Please consult Oracle8i Java 
   Developer's Guide for more information on Java2 security and DBMS_JAVA 
   package.

   Examples of granting or restricting file access permissions:

   DBMS_JAVA.GRANT_PERMISSION('SCOTT',                   -- Oracle user
                              'java.io.FilePermission',  -- permission class
                              '/some/path/*',            -- OS path
                              'read,write');             -- access granted
   DBMS_JAVA.RESTRICT_PERMISSION('PUBLIC',
                                 'java.io.FilePermission',
                                 '/some/path/restricted/*',
                                 'read,write');


   Legal terms and conditions:

   This package and its supporting Java classes are free for all kinds of use,
   including commercial. However, this package is neither public domain nor 
   under any kind of public license, like GPL or MPL. This package is 
   copyrighted work and property of its author. You can not sell, lease or
   otherwise distribute this package for profit, nor can you reverse-engineer
   or modify it. The package and its supporting Java classes are provided AS 
   IS, without any express or implied warranties of any kind, including, but
   not limited to, code stability, quality, or fitness for particular 
   purposes. The author did his best to ensure this code works as intended and
   expected, but in no event of code failure or your inability to use it in
   your particular environment for your particular purposes the author or his
   employer shall be liable to you or any third party affected by such event,
   even if they were aware of the possibility of such failure.

   History:

   v1.01  initially released
   v1.02  added file deleting, renaming and directory creation support
   v1.03  added compression methods, declared JAVA_ERROR exception,
           FileOperations.class optimized a bit to reduce footprint and
           eliminate redundant code
   v1.04  added routines to create and alter ZIP archives in internal LOBs
          optimized FileOperations.class a bit more (removed unnecessary
           variable instantiations, employed BufferedOutputStream to improve
           LOB write performance, eliminated more redundant code, etc.)
          fixed a bug in zip listing routines that caused them to throw 
           IndexOutOfBoundsException exception in most cases.
          split Java code to 8i and 9i versions. 9i version uses enhanced
           LOB APIs not available on 8i - this is actually to avoid the 9i bug
           with DBMS_LOB calls from Java. BE SURE to load correct JAR file into
           9i, or the new ZIP-related routines will not work properly and may
           result in corrupt archives!
   v1.0.5 a few internal Java code optimizations, recompiled with no debug
           info to save a few bytes.
   v1.0.6 implemented a workaround for changed oracle.sql.BLOB.DURATION_xxx
           constants in 9.2.0.4 (and may be earlier) JDBC driver release,
           which caused exception on attempt to create a temporary BLOB with
           older KPRB drivers. Thanks to Simon MgGoun of McGraw-Hill for
           bringing this issue to my attention.
   v1.0.7 added MTIME column to the directory listing table NN$FOPS$DIR_LIST 
           for file modification timestamp.
          added Copy_File and Move_File procedures.

*/

-- Exceptions
--

JAVA_ERROR EXCEPTION;
PRAGMA EXCEPTION_INIT(JAVA_ERROR, -29532);

--
-- Load_BLOB_From_File
--
-- This function returns a temporary BLOB populated with contents
-- of a binary file fully qualified by the filename parameter.
-- BLOB should be freed with DBMS_LOB.FREETEMPORARY when no longer
-- needed (or it will be disposed automatically when session ends).
--
function Load_BLOB_From_File( filename IN VARCHAR2 ) return BLOB;

--
-- Save_BLOB_To_File
--
-- This procedure saves contents of a BLOB into an arbitrary binary
-- file fully qualified by the filename parameter.
--
procedure Save_BLOB_To_File( b        IN BLOB 
                            ,filename IN VARCHAR2 );

--
-- List_Directory
--
-- This procedure fills the NN$FOPS$DIR_LIST temporary table with
-- file names of the file system directory specified by v_directory parameter.
-- java.io.FilePermission of type 'read' must be granted to the invoking user
-- for the directory it tries to list, otherwise security exception will be
-- thrown.
--
procedure List_Directory( v_directory IN VARCHAR2
                         ,list_hidden IN Boolean  := False );


-- the following subprograms work with comressed files (ZIP or JAR),
-- and allow listing contents of an archive or extract files from it.
-- This functionality was suggested by Michael Panayotou <M.Panagiotou@csd.ase.gr>

--
-- List_ZIP
--
-- This procedure fills the NN$FOPS$DIR_LIST temporary table with
-- file names of the files contained in the specified ZIP/JAR file.
-- java.io.FilePermission of type 'read' must be granted to the invoking user
-- for the directory it tries to list, otherwise security exception will be
-- thrown.
--
procedure List_ZIP( zip_file IN VARCHAR2 );

--
-- List_ZIP
--
-- This procedure fills the NN$FOPS$DIR_LIST temporary table with
-- file names of the files contained in the provided ZIP/JAR file.
--
procedure List_ZIP( zip_file IN BLOB );


--
-- Load_BLOB_From_ZIP
--
-- This function returns a temporary BLOB populated with contents
-- of a binary file filename extracted from the zip_file ZIP/JAR file.
-- BLOB should be freed with DBMS_LOB.FREETEMPORARY when no longer
-- needed (or it will be disposed automatically when session ends).
--
function Load_BLOB_From_ZIP( zip_file IN VARCHAR2
                            ,filename IN VARCHAR2 ) return BLOB;

--
-- Load_BLOB_From_ZIP
--
-- This function returns a temporary BLOB populated with contents
-- of a binary file filename extracted from the zip_file ZIP/JAR file.
-- Returned BLOB should be freed with DBMS_LOB.FREETEMPORARY when no longer
-- needed (or it will be disposed automatically when session ends).
--
function Load_BLOB_From_ZIP( zip_file IN BLOB
                            ,filename IN VARCHAR2 ) return BLOB;


--
-- Delete_File
--
-- This procedure attempts to delete a file identified by filename argument.
-- The procedure will raise JAVA_ERROR exception if file was not found or
-- could not be deleted due to file system or security restrictions.
--
procedure Delete_File( filename IN VARCHAR2 );

--
-- Rename_File
--
-- This procedure attempts to rename a file from fnFrom name to fnTo name.
-- The procedure will raise JAVA_ERROR exception if the file was not found
-- or could not be renamed to the new name due to file system or security
-- restrictions (for example, if target file name is already used by another
-- file.) The procedure will NOT move the file to a new location, it will fail
-- if renaming operation causes the file location to be changed.
--
procedure Rename_File( fnFrom IN VARCHAR2
                      ,fnTo   IN VARCHAR2 );

--
-- Copy_File
--
-- This procedure attempts to create a copy of a file identified by fnFrom 
-- with the new name of fnTo. The procedure will raise JAVA_ERROR exception 
-- if the fnFrom file was not found or the fnTo file could not be created 
-- or is not writeable. 
--
procedure Copy_File( fnFrom IN VARCHAR2
                    ,fnTo   IN VARCHAR2 );

--
-- Move_File
--
-- This procedure attempts to move a file identified by fnFrom to the new
-- location fnTo. The procedure will raise JAVA_ERROR exception if the fnFrom
-- file was not found or could not be deleted, or the fnTo file could not be 
-- created or is not writeable. 
--
procedure Move_File( fnFrom IN VARCHAR2
                    ,fnTo   IN VARCHAR2 );

--
-- Create_Directory
--
-- This procedure attempts to create the directory named dirname. If recursive
-- is TRUE, it will attempt to create all parent directories as needed. The
-- procedure will raise JAVA_ERROR exception if the directory or any of its
-- parent directories in recursive mode could not be created. If the procedure
-- fails in recursive mode, some parent directories may have been created
-- anyway.
--
procedure Create_Directory( dirname   IN VARCHAR2
                           ,recursive IN Boolean  := False);

--
-- Deflate
--
-- This function compresses in_blob BLOB using 'deflate' method and returns
-- its compressed representation as TEMPORARY BLOB. Returned BLOB should be
-- freed using DBMS_LOB.freeTemporary() when no longer needed, or it will be
-- released automatically when session ends. The function may raise JAVA_ERROR
-- exception if the input BLOB could not be compressed. Exception message will
-- have error details.
--
function Deflate( in_blob IN BLOB ) return BLOB;

-- 
-- GZIP
--
-- This function compresses in_blob BLOB using 'gzip' method and returns
-- its compressed representation as TEMPORARY BLOB. Returned BLOB should be
-- freed using DBMS_LOB.freeTemporary() when no longer needed, or it will be
-- released automatically when session ends. The function may raise JAVA_ERROR
-- exception if the input BLOB could not be compressed. Exception message will
-- have error details.
--
function GZIP( in_blob IN BLOB ) return BLOB;

--
-- Inflate
--
-- This function decompresses in_blob BLOB compressed using 'deflate' method 
-- and returns its uncompressed representation as TEMPORARY BLOB. Returned BLOB 
-- should be freed using DBMS_LOB.freeTemporary() when no longer needed, or it 
-- will be released automatically when session ends. The function may raise 
-- JAVA_ERROR exception if the input BLOB could not be decompressed. Exception 
-- message will have error details.
--
function Inflate( in_blob IN BLOB ) return BLOB;

--
-- UnGZIP
--
-- This function decompresses in_blob BLOB compressed using 'gzip' method and 
-- returns its uncompressed representation as TEMPORARY BLOB. Returned BLOB 
-- should be freed using DBMS_LOB.freeTemporary() when no longer needed, or it 
-- will be released automatically when session ends. The function may raise 
-- JAVA_ERROR exception if the input BLOB could not be decompressed. Exception 
-- message will have error details.
--
function UnGZIP( in_blob IN BLOB ) return BLOB;

--
-- Create_ZIP
--
-- This function compresses in_blob and returns ZIP archive with compressed
-- in_blob named as filename. Returned BLOB is TEMPORARY and should be freed 
-- using DBMS_LOB.freeTemporary() when no longer needed, or it will be released 
-- automatically when session ends. The function may raise JAVA_ERROR exception 
-- if the input BLOB could not be compressed or ZIP archive could not be
-- created. Exception message will have error details.
--
function Create_ZIP( in_blob           IN BLOB
                    ,filename          IN VARCHAR2
                    ,compression_level IN NUMBER := 9 ) RETURN BLOB;


--
-- Add_To_ZIP
--
-- This procedure takes a zip file zip_blob and adds in_blob to the archive
-- with file name of filename and compression level of compression_level
-- (using Deflate algorithm). If the zip_blob is empty, new archive will be
-- automatically created. If the file already exists in the archive, it will
-- be updated (replaced with in_blob contents). To add a directory, pass a
-- NULL in_blob and make sure that filename is terminated with slash ('/').
-- If anything goes wrong, JAVA_ERROR exception will be raised, exception 
-- message will have error details.
--
procedure Add_To_ZIP( zip_file          IN OUT NOCOPY BLOB
                     ,in_blob           IN BLOB
                     ,filename          IN VARCHAR2
                     ,compression_level IN NUMBER := 9);


--
-- Delete_From_ZIP
--
-- This procedure attempts to delete a file identified by filename from the
-- ZIP archive in zip_file. If the file is not there, nothing will happen.
-- If anything goes wrong, JAVA_ERROR exception will be raised, exception 
-- message will have error details.
--
procedure Delete_From_ZIP( zip_file     IN OUT NOCOPY BLOB
                          ,filename     IN VARCHAR2);

--
-- getVersion
--
-- This function returns current version of the package.
--
function getVersion return varchar2;

end; -- package spec
/

CREATE OR REPLACE PACKAGE BODY UTL_BinFile
AS
/*
   UTL_BinFile						    Version 1.0.7.017
   --------------------------------------------------------------------------

   Utility package for manipulating binary OS/Internal LOB files/archives.

   Copyright(c) 2002-2004 by Vladimir M. Zakharychev
   All rights reserved.
   Written by Vladimir M. Zakharychev (bob@dynamicpsp.com)

   Hit-Media website can be reached at http://www.dynamicpsp.com

   This package REQUIRES com.nnetworks.FileOperations Java class.
   Correct java.io.FilePermission permissions MUST be granted to the invoker
   of the package with DBMS_JAVA.GRANT_PERMISSION() for the package to be
   able to list, read and/or write OS files in particular directories, including
   ZIP/JAR archives. Please consult Oracle8i Java Developer's Guide for more 
   information on Java security and DBMS_JAVA package.
*/

function Load_BLOB_From_File( filename in varchar2 ) return BLOB
is
 language java 
 name 'com.nnetworks.FileOperations.loadFile(java.lang.String) return oracle.sql.BLOB';

procedure Save_BLOB_To_File( b in BLOB, filename in varchar2 )
is
 language java 
 name 'com.nnetworks.FileOperations.saveFile(oracle.sql.BLOB, java.lang.String)';

procedure iListDir( v_directory varchar2 
                   ,list_hidden NUMBER )
is
 language java 
 name 'com.nnetworks.FileOperations.dirList(java.lang.String, int)';

procedure List_Directory( v_directory in varchar2, list_hidden in Boolean := False )
is
begin
 -- Boolean is not translated to a Java type, so we have
 -- to use this stub procedure to pass list_hidden.
 if list_hidden then
  iListDir(v_directory, 1);
 else
  iListDir(v_directory, 0);
 end if;
end List_Directory;

procedure List_ZIP(zip_file in varchar2 )
is
 language java 
 name 'com.nnetworks.FileOperations.zipList(java.lang.String)';

procedure List_ZIP(zip_file in BLOB)
is
 language java
 name 'com.nnetworks.FileOperations.zipList(oracle.sql.BLOB)';

function Load_BLOB_From_ZIP (zip_file in varchar2, filename in varchar2 ) return BLOB
is
 language java
 name 'com.nnetworks.FileOperations.loadFileFromZIP(java.lang.String, java.lang.String) return oracle.sql.BLOB';

function Load_BLOB_From_ZIP (zip_file in BLOB, filename in varchar2 ) return BLOB
is
 language java
 name 'com.nnetworks.FileOperations.loadFileFromZIP(oracle.sql.BLOB, java.lang.String) return oracle.sql.BLOB';

procedure Delete_File( filename IN VARCHAR2 )
is
 language java
 name 'com.nnetworks.FileOperations.deleteFile(java.lang.String)';

procedure Rename_File( fnFrom IN VARCHAR2
                      ,fnTo   IN VARCHAR2 )
is
 language java
 name 'com.nnetworks.FileOperations.renameFile(java.lang.String, java.lang.String)';

procedure Copy_File( fnFrom IN VARCHAR2
                    ,fnTo   IN VARCHAR2 )
is
 language java
 name 'com.nnetworks.FileOperations.copyFile(java.lang.String, java.lang.String)';

procedure Move_File( fnFrom IN VARCHAR2
                    ,fnTo   IN VARCHAR2 )
is
begin
  begin
    -- first try to rename the file
    Rename_File(fnFrom, fnTo);
  exception
    when java_error then
      begin
         -- renaming failed, probably true move is requested
         Copy_File(fnFrom, fnTo);
         begin
           -- try to delete the source file
           Delete_File(fnFrom);
         exception
           when java_error then
              -- undo the copy
              Delete_File(fnTo);
              raise;
         end;
      end;
  end;
end;

procedure iCreateDir( dirname   IN VARCHAR2
                     ,recursive IN NUMBER)
is
 language java
 name 'com.nnetworks.FileOperations.createDirectory(java.lang.String, int)';

procedure Create_Directory( dirname   IN VARCHAR2
                           ,recursive IN Boolean  := False)
is
begin
 -- Boolean is not translated to a Java type, so we have
 -- to use this stub procedure to pass recursive.
 if (recursive) then
  iCreateDir(dirname, 1);
 else
  iCreateDir(dirname, 0);
 end if;
end Create_Directory;

function Deflate( in_blob IN BLOB ) return BLOB
is
 language java
 name 'com.nnetworks.FileOperations.deflate(oracle.sql.BLOB) return oracle.sql.BLOB';

function GZIP( in_blob IN BLOB ) return BLOB
is
 language java
 name 'com.nnetworks.FileOperations.gzip(oracle.sql.BLOB) return oracle.sql.BLOB';

function Inflate( in_blob IN BLOB ) return BLOB
is
 language java
 name 'com.nnetworks.FileOperations.inflate(oracle.sql.BLOB) return oracle.sql.BLOB';

function UnGZIP( in_blob IN BLOB ) return BLOB
is
 language java
 name 'com.nnetworks.FileOperations.ungzip(oracle.sql.BLOB) return oracle.sql.BLOB';


-- Java SPs don't accept arguments with defaults, so we need to
-- declare them separately.
function iCreate_ZIP( in_blob           IN BLOB
                     ,filename          IN VARCHAR2
                     ,compression_level IN NUMBER ) RETURN BLOB
is
 language java
 name 'com.nnetworks.FileOperations.createZip(oracle.sql.BLOB, java.lang.String, int) return oracle.sql.BLOB';

function Create_ZIP( in_blob           IN BLOB
                    ,filename          IN VARCHAR2
                    ,compression_level IN NUMBER := 9 ) RETURN BLOB
is
 begin
  return iCreate_ZIP(in_blob, filename, compression_level);
 end Create_ZIP;

procedure iAdd_To_ZIP( zip_file          IN OUT NOCOPY BLOB
                      ,in_blob           IN BLOB
                      ,filename          IN VARCHAR2
                      ,compression_level IN NUMBER)
is
 language java
 name 'com.nnetworks.FileOperations.addToZip(oracle.sql.BLOB[], oracle.sql.BLOB, java.lang.String, int)';

procedure Add_To_ZIP( zip_file          IN OUT NOCOPY BLOB
                     ,in_blob           IN BLOB
                     ,filename          IN VARCHAR2
                     ,compression_level IN NUMBER := 9)
is
 begin
  iAdd_To_ZIP(zip_file, in_blob, filename, compression_level);
 end Add_To_ZIP;


procedure Delete_From_ZIP( zip_file IN OUT NOCOPY BLOB
                          ,filename IN VARCHAR2)
is
 language java
 name 'com.nnetworks.FileOperations.deleteFromZip(oracle.sql.BLOB[], java.lang.String)';


function getVersion return varchar2
is
begin
 return '1.0.7.017';
end;

end; -- package body
/

GRANT EXECUTE ON UTL_BinFile TO PUBLIC
/
CREATE PUBLIC SYNONYM UTL_BinFile FOR UTL_BinFile
/
SPOOL OFF
