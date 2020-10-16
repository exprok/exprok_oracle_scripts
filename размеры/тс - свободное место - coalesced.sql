select c.TABLESPACE_NAME, round(c.TOTAL_BYTES/(1024*1024*1024)) gb, round(c.BYTES_COALESCED/(1024*1024*1024)) gbc from dba_free_space_coalesced c
