*Coded by: Maria Nguyen and Stephen Vosburgh
 Date: 11/30/2020;
 
Proc Import Out= NBA datafile= "/home/u49461599/NBA STATS FINALACTUALLY.xlsx" DBMS= xlsx replace;
Getnames= Yes;
Sheet= "2007-2008";
Run; 

Data NBA2;
Set NBA;
If Year= 2012 then Delete; *Removed 2012 because it was a 'lockout' season. Within 2012, less games were played than usual;
Run;

/*Hypothesis 1.1*/ 
symbol1 value = trianglefilled color = red I = join;
symbol2 value = square color = blue I = join;
symbol3 value = circle color = green I = join;
symbol4 value = circle color = purple I = join;
symbol5 value = circle color = cyan I= join;
symbol6 value = trianglefilled color = orange I = join;
symbol7 value = square color = pink I = join;
symbol8 value = circle color = brown I = join;
symbol9 value = circle color = black I = join;
symbol10 value = circle color = blueViolet I= join;
Proc gplot data = NBA2;
Where team= 'Oklahoma City Thunder' or team= 'Orlando Magic' or team= 'Philadelphia 76ers' or team='Phoenix Suns' or team='Portland Trail Blazers' or team= 'Sacramento Kings' or team='San Antonio Spurs' or team='Toronto Raptors' or team='Utah Jazz' or team='Washington Wizards';
Title "Number of 3 Pointers Attempted over each Year per Teams";
Plot ThreePA*year= Team;
Run;

*H0: The average amount of three point attempts stayed constant over time.
 HA: The average amount of three point attempts increased over time;
Proc Means Data= NBA2 Mean CLM Alpha= 0.05;
Class Year;
Var ThreePA;
Title "Average of Three Pointer Attempts";
Run;

Proc TTEST Data= NBA2 H0=1484.80 Alpha= 0.05 Sides= U;
Var ThreePA;
Title "One-Sample t-Test on Three Pointer Attempts";
Run;

Proc GLM Data= NBA2;
Class Year;
Model ThreePA= Year;
Means Year/Tukey;
Title "ANOVA Test Three Pointer Attempts";
Run;

/*Hypothesis 1.2*/
symbol1 value = trianglefilled color = red I = join;
symbol2 value = square color = blue I = join;
symbol3 value = circle color = green I = join;
symbol4 value = circle color = purple I = join;
symbol5 value = circle color = cyan I= join;
symbol6 value = trianglefilled color = orange I = join;
symbol7 value = square color = pink I = join;
symbol8 value = circle color = brown I = join;
symbol9 value = circle color = black I = join;
symbol10 value = circle color = blueViolet I= join;
Proc gplot data = NBA2;
Where team= 'Oklahoma City Thunder' or team= 'Orlando Magic' or team= 'Philadelphia 76ers' or team='Phoenix Suns' or team='Portland Trail Blazers'or team= 'Sacramento Kings' or team='San Antonio Spurs' or team='Toronto Raptors' or team='Utah Jazz' or team='Washington Wizards';
Title "Number of 3 Pointers Made over each Year per Teams";
Plot ThreeP*year= Team;
Run;

*H0: The average amount of three pointer made stayed constant over time.
 HA: The average amount of three pointers made increased over time;
Proc Means Data= NBA2 Mean CLM Alpha= 0.05;
Class Year;
Var ThreeP;
Title "Average of Three Pointers Made 2008-2017";
Run;

Proc TTEST Data= NBA2 H0= 537.47 Alpha= 0.05 Sides= U;
Var ThreeP;
Title "One-Sample t-Test on Three Pointer Made";
Run;

Proc GLM Data= NBA2;
Class Year;
Model ThreeP= Year;
Means Year/Tukey;
Title "ANOVA Test Three Pointers Made 2008-2017";
Run;

/*Hypothesis 2*/
Data NBA3;
Set NBA2;
If W <= 25 then Rank= "Bad";
If 25 < W < 41 then Rank= "Below Average";
If 41<= W < 55 then Rank= "Above Average";
If W => 55 then Rank= "Good";
Run;

*H0: The mean three pointers made for all ranks are equal.
 HA: There is at least one significant difference between the ranks for mean three pointers made;
Proc GLM Data= NBA3;
Class Rank;
Model ThreeP= Rank;
Means Rank/Tukey;
Title "ANOVA Test Between Rank and Three Pointers Made";
Run;

/*Hypothesis 3*/
*H0: There is no association with the number of wins and the number of three pointer attempts.
 HA: There is an association with the number of wins and the number of three pointer attempts;
Data NBAA;
Set NBA2;
Where year=2015 or year=2016 or year=2017;
run;

Data transform2;
Set NBAA;
lnThreePA= log(ThreePA);
lnw= log(W);
Run;

Proc Reg data=transform2;
Model w=threePA;
Title "Linear Model: Wins (Y) Three Pointer Attempts (X)";
Run;

Proc Reg data=transform2;
Model lnw=lnthreePA;
Title "Power Model: Wins (Y) Three Pointer Attempts (X)";
Run;

/*Hypothesis 4*/
*H0: The average amount of three pointers made in 2017 for Western Conference NBA teams is the same as 
 The number of three pointers made from Eastern Conference NBA teams.
 HA: The average amount of three pointers made in 2017 from Western Conference NBA teams is significantly 
 different Eastern Conference NBA teams;
Proc GLM data= NBA2;
Class Conf;
Model ThreeP= Conf;
Means Conf;
Title "ANOVA Test Between Conferences and Three Pointer Attempts";
Run;

