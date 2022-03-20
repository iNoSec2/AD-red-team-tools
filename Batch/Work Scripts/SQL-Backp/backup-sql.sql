declare @name varchar(max) = 
'C:\backups\Backups' 
+  
case datepart(weekday, getdate()) 
when 1 then 'Sunday'
when 2 then 'Monday'
when 3 then 'Tuesday'
when 4 then 'Wednesday'
when 5 then 'Thursday'
when 6 then 'Friday'
when 7 then 'Saturday'
end
+
'.bak'
print @name
EXEC sp_dropdevice  'propharm'
EXEC sp_addumpdevice 'disk',  'propharm', @name 
BACKUP database propharm TO propharm WITH NOFORMAT, INIT,  NAME = N'propharm-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10


GO