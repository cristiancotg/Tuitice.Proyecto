package ejemplocup;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;


public class FactorCup {

    public final static int GENERAR = 1;
    public final static int EJECUTAR = 2;
    public final static int SALIR = 3;

   
    public static void main(String[] args) {
        java.util.Scanner in = new Scanner(System.in);
        int valor = 0;
        do {
            
            System.out.println("1) Generar");
            System.out.println("2) Ejecutar");
            System.out.println("3) Salir");
            System.out.print("Opcion: ");
            valor = in.nextInt();
            switch (valor) {
            
                /*  GENERAR EL ANALIZADOR LEXICO Y SINTACTICO*/
            
                case GENERAR: {
                    System.out.println("\n*** Generando Analizadores ***\n");
                    String archLexico = "";
                    String archSintactico = "";
                    if (args.length > 0) {
                        System.out.println("\n*** Procesando archivos custom ***\n");
                        archLexico = args[0];
                        archSintactico = args[1];
                    } else {
                        System.out.println("\n*** Procesando archivo default ***\n");
                        archLexico = "alexico.flex";
                        archSintactico = "asintactico.cup";
                    }
                    String[] alexico = {archLexico};
                    String[] asintactico = {"-parser", "AnalizadorSintactico", archSintactico};
                    jflex.Main.main(alexico);
                    try {
                        java_cup.Main.main(asintactico);
                    } catch (Exception ex) {
                        Logger.getLogger(FactorCup.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    
                    boolean mvAL = moverArch("AnalizadorLexico.java");
                    boolean mvAS = moverArch("AnalizadorSintactico.java");
                    boolean mvSym= moverArch("sym.java");
                    if(mvAL && mvAS && mvSym){
                        System.exit(0);
                    }
                    System.out.println(" Generado ");
                    break;
                }
                case EJECUTAR: {
                    /* ANALIZADOR LEXICO Y SINTACTICO*/
                    String[] archivoPrueba = {"test.txt"};
                    AnalizadorSintactico.main(archivoPrueba);
                    System.out.println("Ejecutado");
                    break;
                }
                case SALIR: {
                    System.out.println("Usted ha salido del sistema");
                    break;
                }
                default: {
                    System.out.println("Opcion incorrecta");
                    break;
                }
            }
        } while (valor != 3);

    }

    public static boolean moverArch(String archNombre) {
        boolean efectuado = false;
        File arch = new File(archNombre);
        if (arch.exists()) {
            System.out.println("\n*** Moviendo " + arch + " \n***");
            Path currentRelativePath = Paths.get("");
            String nuevoDir = currentRelativePath.toAbsolutePath().toString()
                    + File.separator + "src" + File.separator
                    + "ejemplocup" + File.separator + arch.getName();
            File archViejo = new File(nuevoDir);
            archViejo.delete();
            if (arch.renameTo(new File(nuevoDir))) {
                System.out.println("\n*** Generado " + archNombre + "***\n");
                efectuado = true;
            } else {
                System.out.println("\n*** No movido " + archNombre + " ***\n");
            }

        } else {
            System.out.println("\n*** Codigo no existe ***\n");
        }
        return efectuado;
    }
}