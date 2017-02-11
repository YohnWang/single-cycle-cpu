%{
#include<stdio.h>
#include<stdlib.h>
enum {NONE,ADD,SUB,AND,OR,SLT,LW,SW,BEQ,ADDI,JMP,NUM,REG};
struct ins
{
	unsigned int op:6;
	unsigned int funct:6;
};

%}


%%
add {return ADD;}
sub {return SUB;}
and {return AND;}
or  {return OR;}
slt {return SLT;}
lw  {return LW;}
sw  {return SW;}
beq {return BEQ;}
addi {return ADDI;}
jmp {return JMP;}

[+-]?[0-9]+ {return NUM;}
r[0-9]+ {return REG;}

[\n\t]|" " {}
. {}

%%
int main()
{
	unsigned int ins;
	int rs,rt,rd;
	char buf[64];
	while(1)
	{
		switch(yylex())
		{
		case ADD:
			ins=0;
			yylex();
			rd=atoi(yytext+1);
			yylex();
			rs=atoi(yytext+1);
			yylex();
			rt=atoi(yytext+1);
			ins=0b100000|(rd<<11)|(rt<<16)|(rs<<21);
			printf("%.8x // add r%d,r%d,r%d\n",ins,rd,rs,rt);
			break;
		case SUB:
			ins=0;
			yylex();
			rd=atoi(yytext+1);
			yylex();
			rs=atoi(yytext+1);
			yylex();
			rt=atoi(yytext+1);
			ins=0b100010|(rd<<11)|(rt<<16)|(rs<<21);
			printf("%.8x // sub r%d,r%d,r%d\n",ins,rd,rs,rt);
			break;
		case AND:
			ins=0;
			yylex();
			rd=atoi(yytext+1);
			yylex();
			rs=atoi(yytext+1);
			yylex();
			rt=atoi(yytext+1);
			ins=0b100100|(rd<<11)|(rt<<16)|(rs<<21);
			printf("%.8x // and r%d,r%d,r%d\n",ins,rd,rs,rt);
			break;
		case OR:
			ins=0;
			yylex();
			rd=atoi(yytext+1);
			yylex();
			rs=atoi(yytext+1);
			yylex();
			rt=atoi(yytext+1);
			ins=0b100101|(rd<<11)|(rt<<16)|(rs<<21);
			printf("%.8x // or r%d,r%d,r%d\n",ins,rd,rs,rt);
			break;
		case SLT:
			ins=0;
			yylex();
			rd=atoi(yytext+1);
			yylex();
			rs=atoi(yytext+1);
			yylex();
			rt=atoi(yytext+1);
			ins=0b101010|(rd<<11)|(rt<<16)|(rs<<21);
			printf("%.8x // slt r%d,r%d,r%d\n",ins,rd,rs,rt);
			break;
		case ADDI:
			ins=0b001000<<26;
			yylex();
			rt=atoi(yytext+1);
			yylex();
			rs=atoi(yytext+1);
			yylex();
			rd=atoi(yytext);
			ins=ins|(rt<<16)|(rs<<21)|(unsigned short)rd;
			printf("%.8x // addi r%d,r%d,%d\n",ins,rt,rs,rd);
			break;
		case LW:
			ins=0b100011<<26;
			yylex();
			rt=atoi(yytext+1);
			yylex();
			rs=atoi(yytext+1);
			yylex();
			rd=atoi(yytext);
			ins=ins|(rt<<16)|(rs<<21)|(unsigned short)rd;
			printf("%.8x // lw r%d,r%d,%d\n",ins,rt,rs,rd);
			break;
		case SW:
			ins=0b101011<<26;
			yylex();
			rt=atoi(yytext+1);
			yylex();
			rs=atoi(yytext+1);
			yylex();
			rd=atoi(yytext);
			ins=ins|(rt<<16)|(rs<<21)|(unsigned short)rd;
			printf("%.8x // sw r%d,r%d,%d\n",ins,rt,rs,rd);
			break;
		case BEQ:
			ins=0b000100<<26;
			yylex();
			rt=atoi(yytext+1);
			yylex();
			rs=atoi(yytext+1);
			yylex();
			rd=atoi(yytext);
			ins=ins|(rt<<16)|(rs<<21)|(unsigned short)rd;
			printf("%.8x // beq r%d,r%d,%d\n",ins,rt,rs,rd);
			break;
		case JMP:
			ins=0b000010<<26;
			yylex();
			rd=atoi(yytext);
			ins=ins|rd;
			printf("%.8x // jmp %d\n",ins,rd);
			break;
		default:return 0;
		}
	}
}

int yywrap()
{
	return 1;
}