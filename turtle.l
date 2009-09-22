/* file name: turtle.l */

/* lexer for turtle */
/* flex specification */

%{

%}

DIGIT  [0-9]
LETTER [A-Za-z]
COMMENT .

%%

{DIGIT}+("."{DIGIT}+)?  {
         yylval.val = atof(yytext); return INTEGER; }

[ \t\n]    /* ignore whitespace */
				

turtle			{return TURTLE;}

var			{return VAR;}

fun			{return FUN;}

up			{return UP;}

down			{return DOWN;}

moveto			{return MOVETO;}

read			{return READ;}

if			{return IF;}

else			{return ELSE;}

while			{return WHILE;}

return			{return RETURN;}

==			{return LOGICAL_EQUALS;}

{LETTER}({LETTER}|{DIGIT}|_|')*  	{ return IDENTIFIER; }

"//"({COMMENT}+)?

<<EOF>>  yyterminate();  /* signal end of dialogue */

\n       return yytext[0];
.        return yytext[0];

%%