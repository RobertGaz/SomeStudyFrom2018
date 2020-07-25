
CREATE TABLE logs_5 (time datetime, name nvarchar(100), type nvarchar(100))



CREATE TRIGGER log_trig_5
ON all server with execute as owner
FOR LOGON
AS  
DECLARE @data XML  
SET @data = EVENTDATA()  
INSERT into logs_5
   VALUES  
   (GETDATE(),   
   @data.value('(/EVENT_INSTANCE/LoginName)[1]', 'nvarchar(100)'),  
   @data.value('(/EVENT_INSTANCE/LoginType)[1]', 'nvarchar(100)') )
