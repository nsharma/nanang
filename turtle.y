/* file name turtle.y */

/* Assignment 2 */
/* COMP3610 */

/*  Bison specification */

/* some useful documentation */


%token <val>  INTEGER
%token TURTLE
%token VAR
%token FUN
%token UP
%token DOWN
%token MOVETO
%token READ
%token IF
%token ELSE
%token WHILE
%token RETURN
%token LOGICAL_EQUALS

%type  <val>  expression

%left '-' '+'
%left '*'
%nonassoc UMINUS
%right '^'

%%

input
    :  /* empty */
    |  input program
    ;

program
    	: TURTLE IDENTIFIER varDecs functionDecs compoundStatement
	;

	
functionDecs 
	: /* empty */
	| function functionDecs 
	;


function
	: FUN IDENTIFIER '(' parameters ')' varDecs compoundStatement
	;
		
parameters
	: /* empty */
	| idents
	;
		
idents
	: IDENTIFIER
	| IDENTIFIER ',' idents
	;
				
functionCall
	: IDENTIFIER '(' arguments ')'
	;

arguments
	: /* empty */
	| expressions
	;
		
expressions
	: expression
	| expression ',' expressions
	;

expression
    	: INTEGER
	| IDENTIFIER
	| functionCall	
	| expression '+' expression     { $$ = $1 + $3; }
    	| expression '-' expression     { $$ = $1 - $3; }
    	| expression '*' expression     { $$ = $1 * $3; }
    	| '-' expression %prec UMINUS  	{ $$ = - $2; }
    	| '(' expression ')'          	{ $$ = $2; }
    	;
	
	
statement
	: UP
	| DOWN
	| MOVETO '(' expression ',' expression ')'
	| READ '(' IDENTIFIER ')'
	| IDENTIFIER '=' expression
	| IF '(' comparison ')' compoundStatement
	| IF '(' comparison ')' compoundStatement ELSE compoundStatement
	| WHILE '(' comparison ')' compoundStatement
	| RETURN expression
	| functionCall
	;

compoundStatement
	: '{' statements '}'
	;
		
statements
	: statement
	| statement statements
	;

comparison
	: expression LOGICAL_EQUALS expression
	| expression '<' expression
	;


varDecs
	: /* empty */
	| variable varDecs
	;

variable
	: VAR IDENTIFIER '=' expression
	| VAR IDENTIFIER
	;


%%

symrec *sym_table = (symrec *)0;

main ()
{
  yyparse ();
}

yyerror (char *s)  /* Called by yyparse on error */
{
  printf ("\terror: %s\n", s);
}