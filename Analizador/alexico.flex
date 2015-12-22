
/* -------------------ANALIZADOR LEXICO------------------- */
package ejemplocup;
import java_cup.runtime.*;
import java.io.Reader;
      
%%
%class AnalizadorLexico
%line
%column
%cup
   
%{
    /*  GENERAMOS UN java_cup.Symbol PARA GUARDAR EL TOKEN  */
    
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    /* GENERAMOS UN  Symbol PARA EL TOKEN Y SU VALOR */
       
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}
  
  
//GRANATICA DEL ANALIZADOR   
EXP_ALPHA=[A-Za-z]
EXP_DIGITO=[1-9] 
CERO=0
EXP_ALPHANUMERIC={EXP_ALPHA}|{EXP_DIGITO}|{CERO}
IDENTIFICADOR={EXP_ALPHA}({EXP_ALPHANUMERIC})*

Salto = \r|\n|\r\n
Espacio     = {Salto} | [ \t\f]

Entero = 0 | [1-9][0-9]*



%% 
   

   
<YYINITIAL> {
   
    /* Regresa que el token SEMI declarado en la clase sym fue encontrado. */
    ";"                { //System.out.print(" ; ");
	                     return symbol(sym.SEMI); }
    /* Regresa que el token OP_SUMA declarado en la clase sym fue encontrado. */
    "+"                {  //System.out.print(" + ");
                          return symbol(sym.OP_SUMA); }
    /* Regresa que el token OP_SUMA declarado en la clase sym fue encontrado. */
    "-"                {  //System.out.print(" - ");
                          return symbol(sym.OP_RESTA); }
    /* Regresa que el token OP_SUMA declarado en la clase sym fue encontrado. */
    "*"                {  //System.out.print(" * ");
                          return symbol(sym.OP_MULT); }
    /* Regresa que el token PARENIZQ declarado en la clase sym fue encontrado. */
    "("                {  //System.out.print(" ( ");
                          return symbol(sym.PARENIZQ); }
                          /* Regresa que el token PARENIZQ declarado en la clase sym fue encontrado. */
    ")"                {  //System.out.print(" ) ");
                          return symbol(sym.PARENDER); }
						  
	
	":"                {  System.out.print(" : ");
                          return symbol(sym.DOSPUNTOS); }
						  
	"++"                {  System.out.print(" ++ ");
                          return symbol(sym.INCREMENTO); }					  
						  
						  
   "="                {  System.out.print(" IGUAL ");
                          return symbol(sym.IGUAL); }
						  
   "["                {  System.out.print(" [ ");
                          return symbol(sym.corchIZQ); }
						  
   "]"                {  System.out.print(" ] ");
                          return symbol(sym.corchDER); }
						  
						  
// RESTRINGE TOKENS, SOLO CON LOS DEL DICCIONARIO						  						  
						    
   "INT"                {  System.out.print(" INT ");
                          return symbol(sym.INT); }
						  
  "FLOAT"                {  System.out.print(" FLOAT ");
                          return symbol(sym.FLOAT); }

 "CHAR"                {  System.out.print(" CHAR ");
                          return symbol(sym.CHAR ); }
						  
 "BOOL "                {  System.out.print(" BOOL ");
                          return symbol(sym.BOOL ); }
						  
 "STRING"                {  System.out.print(" STRING ");
                          return symbol(sym.STRING); }
						  
   
    /* SI ENCUENTRA UN TOKEN E IMPRIME Y OBTIENE EL VALOR DE LA CADENA yytext
        AL CONVERTIRLA A ENTERO*/
		
	{CERO}      {   System.out.print(yytext()); 
                      return symbol(sym.CERO); }
		
		
    {Entero}      {   System.out.print(yytext()); 
                      return symbol(sym.ENTERO, new Integer(yytext())); }
					  
					  
	{IDENTIFICADOR}      {   System.out.print(yytext()); 
                      return symbol(sym.IDENTIFICADOR, new String (yytext())); }

					  
   

    /* IGNORA ESPACIO EN BLANCO */
    {Espacio}       { /* ignora el espacio */ } 	
	
	
}


/* SI TOKEN NO COINCIDE, NINGUNA REGLA TOKEN ILEGAL */

[^]                    { throw new Error("Caracter ilegal <"+yytext()+">"); }
