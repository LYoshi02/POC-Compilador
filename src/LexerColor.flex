import compilerTools.TextColor;
import java.awt.Color;

%%
%class LexerColor
%type TextColor
%char
%{
    private TextColor textColor(long start, int size, Color color){
        return new TextColor((int) start, size, color);
    }
%}
/* Variables básicas de comentarios y espacios */
TerminadorDeLinea = \r|\n|\r\n
EntradaDeCaracter = [^\r\n]
EspacioEnBlanco = {TerminadorDeLinea} | [ \t\f]
ComentarioTradicional = "/*" [^*] ~"*/" | "/*" "*"+ "/"
FinDeLineaComentario = "//" {EntradaDeCaracter}* {TerminadorDeLinea}?
ContenidoComentario = ( [^*] | \*+ [^/*] )*
ComentarioDeDocumentacion = "/**" {ContenidoComentario} "*"+ "/"

/* Comentario */
Comentario = {ComentarioTradicional} | {FinDeLineaComentario} | {ComentarioDeDocumentacion}

/* Identificador */
Letra = [A-Za-zÑñ_ÁÉÍÓÚáéíóúÜü]
Digito = [0-9]
Identificador = {Letra}({Letra}|{Digito})*

/* Número */
Numero = 0 | [1-9][0-9]*
%%

/* Comentarios o espacios en blanco */
{Comentario} { return textColor(yychar, yylength(), new Color(146, 146, 146)); }
{EspacioEnBlanco} { /*Ignorar*/ }

/* Identificador */
\${Identificador} { /*Ignorar*/ }

/* Tipos de datos */
numero | 
color { return textColor(yychar, yylength(), new Color(148, 58, 173)); }

/* Numero */
{Numero} { return textColor(yychar, yylength(), new Color(35, 120, 147)); }

/* Colores */
#[{Letra}|{Digito}]{6} { return textColor(yychar, yylength(), new Color(224, 195, 112)); }

/* Operadores de agrupacion */
\( |
\) |
\{ |
\} { return textColor(yychar, yylength(), new Color(169, 155, 179)); }

/* Signos de puntuacion */
\, |
\; { return textColor(yychar, yylength(), new Color(169, 155, 179)); }

/* Operador de asignacion */
--> { return textColor(yychar, yylength(), new Color(169, 155, 179)); }

/* Movimiento */
adelante |
atras |
izquierda |
derecha |
norte |
sur |
este |
oeste { return textColor(yychar, yylength(), new Color(17, 94, 153)); }

/* Pintar */
pintar { return textColor(yychar, yylength(), new Color(212, 129, 6)); }

/* Detener Pintar */
deterPintar { return textColor(yychar, yylength(), new Color(255, 64, 129)); }

/* Tomar */
tomar |
poner { return textColor(yychar, yylength(), new Color(102, 41, 120)); }

/* Lanzar Moneda */
lanzarMoneda { return textColor(yychar, yylength(), new Color(239, 108, 0)); }

/* Ver */
izquierdaEsObstaculo |
izquierdaEsClaro |
izquierdaEsBaliza |
izquierdaEsBlanco |
izquierdaEsNegro |
frenteEsObstaculo |
frenteEsClaro |
frenteEsBaliza |
frenteEsBlanco |
frenteEsNegro |
derechaEsObstaculo |
derechaEsClaro |
derechaEsBaliza |
derechaEsBlanco |
derechaEsNegro { return textColor(yychar, yylength(), new Color(150, 0, 80)); }

/* Repetir */
repetir |
repetirMientras { return textColor(yychar, yylength(), new Color(121, 107, 255)); }

/* Detener Repetir */
interrumpir { return textColor(yychar, yylength(), new Color(255, 64, 129)); }

/* Estructura si */
si |
sino { return textColor(yychar, yylength(), new Color(48, 63, 129)); }

/* Operadores logicos */
\& |
\| { return textColor(yychar, yylength(), new Color(48, 63, 159)); }

/* Final (detener ejecucion) */
final { return textColor(yychar, yylength(), new Color(198, 40, 40)); }

/* -- ERRORES -- */
/* Numero erroneo */
0{Numero} { /*Ignorar*/ }
/* Identificador erroneo */
{Identificador} { /*Ignorar*/ }

. { /* Ignorar */ }