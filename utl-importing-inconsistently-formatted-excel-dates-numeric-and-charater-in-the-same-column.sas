Importing inconsistently formatted excel dates numeric and charater in the same column

github
https://tinyurl.com/ttfgenw
https://github.com/rogerjdeangelis/utl-importing-inconsistently-formatted-excel-dates-numeric-and-charater-in-the-same-column

SAS Forum
download excel from
https://communities.sas.com/t5/New-SAS-User/Trouble-Importing-XLS-File-Into-SAS/m-p/632815


libname xel "d:/xls/samples.xlsx";

* I created a named range 'dates', you can use '[riskfactoe$];

data have;
  set xel.dates(
      dbsastype=(
           dob = 'char(15)' ));
run;quit;

libname xel clear;

*
 _                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

d:/xls/samples.xlsx (named range dates)
                                          Character and
                                           Numeric
  +---------------------------------------------------+     -------------+
  |     A      |     A      |    B       |     C      |  .. |    AK      |
  +---------------------------------------------------+     -------------+
1 | SITEID     |  SUBJID    |  INITIALS  |   DOB      |     | LIFESATID  |
  +------------+------------+------------+------------+     +------------+
2 |    11      |    1101    |     C      | 25JUL70    |     |     2      |
  +------------+------------+------------+------------+     +------------+
3 |    11      |    1102    |    RAJ     | 2/19/60    |     |     3      |
  +------------+------------+------------+------------+     +------------+
4 |    11      |    1103    |    SK      | 12AUG1960  |     |     2      |
  +------------+------------+------------+------------+     +------------+
5 |    11      |    1104    |    AJ      | 08/04/59   |     |     6      |
  +------------+------------+------------+------------+     +------------+
6 |    11      |    1105    |    IO      | 5/26/86    |     |     7      |
  +------------+------------+------------+------------+     +------------+
7 |    11      |    1106    |    BG      | Jan 5 '82  |     |     7      |
  +------------+------------+------------+------------+     +------------+
  |   ...      |   ...      |   ...      |            |  .. |            |
  +------------+------------+------------+------------+     +------------+
N |    11      |    1199    |   RA       | 4-4-64     |  .. |     6      |
  +------------+------------+------------+------------+     +------------+

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

                                               ===========
WORK.WANT obs=774                               anydtdte15.
                                               ==========
  SITEID    SUBJID    INITIALS    DOB             DATEFIX    STATE

    11       1101       CIM       25JUL70       25JUL1970    NJ
    11       1102       AW        11AUG75       11AUG1975    PA
    11       1103       SF        2/19/60       19FEB1960    NJ
    11       1104       DAH       4-12-58       12APR1958    NJ
    11       1105       JRV       12AUG1960     12AUG1960    PA
    11       1106       DG        4-4-64        04APR1964    PA
    11       1107       GCB       08/04/59      04AUG1959    NJ
    11       1108       SS        2/22/66       22FEB1966    NM
    11       1109       IA        5/26/86       26MAY1986    Pennsylvania
    11       1110       EY        7/4/1985      04JUL1985    PA
    11       1111       N.Z       5/18/1981     18MAY1981    PA

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;
* I created a named range 'dates', you can use '[riskfactoe$];

libname xel "d:/xls/samples.xlsx";

data have;
  set xel.dates(
      dbsastype=(
           dob = 'char(15)' ));
run;quit;

libname xel clear;

data want;

  set have;

  date=upcase(compbl(dob));

  datefix=input(date,anydtdte15.);

run;quit;


proc print data=want width=min;
  format datefix date9.;
  var siteid subjid initials dob datefix state;
run;quit;


