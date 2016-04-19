CREATE FUNCTION dbo.udfConvertJulianDate2
(@nJulianDate NUMERIC(9))
RETURNS DATETIME
AS
BEGIN

  DECLARE @YearOffset int
  DECLARE @JulianDate  int
  SET @YearOffset = CONVERT(int,@nJulianDate / 1000)  --108 for 2008, right? 1900 + 108
  SET @JulianDate = CONVERT(int,CONVERT(int,@nJulianDate) % 1000) --modulus, ie 241 (< 365/6 leap year

RETURN DATEADD(dd,@JulianDate,DATEADD(yyyy,@YearOffset,CONVERT(datetime,'1900-01-01')) )

END
