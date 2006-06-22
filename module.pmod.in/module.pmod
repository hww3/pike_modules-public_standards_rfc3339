constant __author = "Bill Welliver <hww3@riverweb.com>";
constant __version = "1.0";

//! A Calendar wrapper for reading and writing RFC 3339 Timestamps.

//!
object parse_fulldatetime(string date)
{
  object cal;

  string d, t;

  sscanf(date, "%s%*[ Tt]%s", d, t);

  string m, o;

  sscanf(t, "%s%[Zz+-]%s", t, m, o);
 
  if(m == "Z" || m == "z")
    o = "";
  else o = m + o;

  string nt = d+ " " + t  + " UTC" + o;

  write("nt: " + nt + "\n");

  cal = Calendar.parse("%Y-%M-%D %h:%m:%s %z", nt);

  return cal;
}

//!
string make_fulldatetime(object cal)
{
  return make_fulldate(cal) + "T" + make_fulltime(cal);
}

//!
string make_fulldate(object cal)
{
   string fulldate = "";

    fulldate = cal->year_no() + "-" + sprintf("%02d", cal->month_no()) + 
      "-" + sprintf("%02d", cal->month_day());

   return fulldate;
}

//!
string make_fulltime(object cal)
{
  return make_partialtime(cal) + make_offset(cal);
}

//!
string make_offset(object cal)
{
  if(cal->utc_offset() == 0) return "Z";

  int c = cal->utc_offset();

  return sprintf("%1s%02d:%02d", ((c<0)?"+":"-"), abs(c)/3600, abs(c)%3600);
}

//!
string make_partialtime(object cal)
{
  return sprintf("%02d:%02d:%02d",cal->hour_no(), cal->minute_no(), 
    cal->second_no());
}

