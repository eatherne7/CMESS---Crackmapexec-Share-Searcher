# CMESS - Crackmapexec Share Searcher
<ins>Description:</ins>

A no frills shell script that searches for a filename keyword in shares discovered by crackmapexec output. I didn't want to mount each file share discovered and recursively search, as this can often wreak havoc with older windows servers. So instead the script uses smbclient to connect to the share, and dump the share's contents to a temporary file, which it then searches for the specificed keyword/filename. You may not need the TMPDIR export but i found with massive fileshares, the use of `tac` filled up /tmp pretty quickly.

I use this script regularly, alongside t3l3machus' great tool - [t3l3machus/eviltree](https://github.com/t3l3machus/eviltree)


<ins>Note:</ins>
- Be sure to Replace the TEMP_DIRECTORY, DOMAIN, USERNAME and PASSWORD placeholders with your own.
- There's no error checking :)
- The expected format of the shares input file is as follows:
  
SMB,10.100.1.11,445,server11,ShareName1$,READ,  
SMB,10.100.1.11,445,server11,MyShare,READ-WRITE,  
SMB,10.100.1.99,445,server99,Another_share$,READ-WRITE,






