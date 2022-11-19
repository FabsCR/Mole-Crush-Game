include "emu8086.inc"
    ORG 100h
.model small
.stack
    DB 100H dup(?)
.data
    
    ; Integrante:
    ; Fabian Jose Fernandez Fernandez
       
            coordx db ?    ; cx
            coordY db ?    ; dx
            msj1 db "                     ////////////////////\\\\\\\\\\\\\\\\\ ",10,13,"$"
            msj2 db "                    <      TECNOLOGICO DE COSTA RICA      >",10,13,"$"
            msj3 db "                     \\\\\\\\\\\\\\\\\\\\///////////////// ",10,13,"$"

            
            mtrz2 db "                                 ------------                            ",10,13,"$"
            mtrz3 db "                                 |          |                         ",10,13,"$"
            mtrz4 db "                                 |          |                         ",10,13,"$"
            mtrz5 db "                                 |          |                        ",10,13,"$"
            mtrz6 db "                                 |          |                         ",10,13,"$"  
            mtrz7 db "                                 |          |                        ",10,13,"$"                                
            mtrz8 db "                                 ------------                          ",10,13,"$" 
            
    simbolo1  db ?,"$"
    simbolo2  db ?,"$"
    chooseSim db "Escoge un simobolo ",10,13,"$"
    
    name1     db 20 dup(" "),"$"
    name2     db 20 dup(" "),"$"                          
    
    salto     db 10,13,"$"
    
    smsInicio1  db "                    **************************************** ",10,13,"$" 
    smsInicio2  db "                    *                                      * ",10,13,"$"
    smsInicio3  db "                    *                                      * ",10,13,"$"
    smsInicio4  db "                    * (:CAMPUS TECNOLOGICO DE SAN CARLOS:) * ",10,13,"$"
    smsInicio5  db "                    *             (:ESTUDIANTE:)           * ",10,13,"$"
    smsInicio6  db "                    *                                      * ",10,13,"$"
    smsInicio7  db "                    *                                      * ",10,13,"$"
    smsInicio8  db "                    *        (:Fabian Fernandez:)          * ",10,13,"$"
    smsInicio9  db "                    *                                      * ",10,13,"$"
    smsInicio10 db "                    *                                      * ",10,13,"$"
    smsInicio11 db "                    *                                      * ",10,13,"$"
    smsInicio12 db "                    *           (:PROFESORA:)              * ",10,13,"$"  
    smsInicio13 db "                    *               (:ROCIO QUIROS:)       * ",10,13,"$"
    smsInicio14 db "                    *                                      * ",10,13,"$"
    smsInicio15 db "                    *        (:  ==============   :)        * ",10,13,"$"
    smsInicio16 db "                    *        (: < APLASTA TOPOS>  :)        * ",10,13,"$"
    smsInicio17 db "                    *        (:  ==============   :)        * ",10,13,"$" 
    smsInicio18 db "                    *                                      * ",10,13,"$"
    smsInicio19 db "                    **************************************** ",10,13,"$"
    
    giveName1  db "Ingrese el nombre del Jugador1: ",10,13,"$"
    giveName2  db "Ingrese el nombre del Jugador2: ",10,13,"$"
    
    startG     db "El juego ha empezado",10,13,"$"
    
    botones db "                  Derrota [D]   Resetear [R]   Salir [X]"
    limpiar db "   ", "$"
    
    puntosJugador1 db 10
    puntosJugador2 db 10
    
    marcasJugador1 db 5
    marcasJugador2 db 4
    
    turnoJugadorX  db 0
    
    
    topo1          db 1
    topo2          db 1
    topo3          db 1
    topo4          db 1
    
     topo5          db 1
      topo6          db 1
     
    
    timeTopo1      db 19
    timeTopo2      db 17
    timeTopo3      db 20
    timeTopo4      db 15
     timeTopo5      db 20
    timeTopo6      db 15 
    
    atrapadoTopo1  db 0
    atrapadoTopo2  db 0
    atrapadoTopo3  db 0
    atrapadoTopo4  db 0
    atrapadoTopo5  db 0
    atrapadoTopo6  db 0 
    pasadas        db 0
    
    
.code
    
    mov ax, @data
    mov ds, ax   
    
;---------macros y procedimientos-----------
    
    imprime macro text;Imprime un sms por pantalla 
        lea dx, text
        mov ah, 09h
        int 21h
    endm 
    
    beep macro ; macro que para que se escuhe un sonido
        mov dl, 07h ; El 07 en ascii corresponde al "beep", la interrupcion pide que eso este en dl
        mov ah, 02h 
        int 21h     ; lee el valor que tiene dl
    endm
    
    imprimeNumeros macro numero; macro que manda a imprimir un numero con mas de un caracter
        xor ax,ax
        mov al, numero
        call print_num
    endm
    
    clearScreen macro
        mov ax,0003h                    ;interrupcion deh servico 0003h limpia terminal 
        int 10h
    endm
    
    posicionar macro fila, columna; macro para posicionar donde se quiere escribir el caracter 
        mov ah, 2
        mov dh, fila ; la interrupcion pide que en dh vaya la fila
        mov dl, columna ; la interrupcion pide que en dl vaya la columna
        mov bh, 0 ; en la pagina 0
        int 10h
    endm 
    
    imprimeCaracter macro caracter, colorsito ; macro para imprimer el caracter donde se haya posicionado el cursor
      
     
         mov ah , 0Ah
         mov al, caracter
         mov bh, 0
         mov cx, 1
         int 10h
         
         MOV AH,9H ; Interrupcion que permite pintar el caracter
         MOV AL,caracter
         
           
         MOV BX, colorsito
            
         mov cx, 1
         int 10h 
  
     
    endm 
    
    zimJug1 macro  
        posicionar 8, 35
        imprimeCaracter simbolo1, 5
        
        ;cx 013Fh                  
        posicionar 8, 39  ;se posiciona en pantalla el cursor en esa fila y columna
        imprimeCaracter simbolo1, 4
        
        ;
        posicionar 8, 41
        imprimeCaracter simbolo1, 3
        
        ;
        posicionar 10, 35
        imprimeCaracter simbolo1, 2
        
        ;
        posicionar 10, 39
        imprimeCaracter simbolo1, 3
        
        ;
        posicionar 10, 41
        imprimeCaracter simbolo1, 2 
    endm
    
    zimJug2 macro  
        posicionar 8, 35
        imprimeCaracter simbolo2, 5
        
        ;cx 013Fh                  
        posicionar 8, 39  ;se posiciona en pantalla el cursor en esa fila y columna
        imprimeCaracter simbolo2, 4
        
        ;
        posicionar 8, 41
        imprimeCaracter simbolo2, 3
        
        ;
        posicionar 10, 35
        imprimeCaracter simbolo2, 2 
        
        ;
        posicionar 10, 39
        imprimeCaracter simbolo2, 3
        
        ;
        posicionar 10, 41
        imprimeCaracter simbolo2, 2
         
    endm
    
    
    
    
    ;Dibuja los simbolos del jugador 1
    
    simJug1 macro  
        posicionar 8, 35
        imprimeCaracter simbolo1, 5
        
        ;cx 013Fh                  
        posicionar 8, 39  ;se posiciona en pantalla el cursor en esa fila y columna
        imprimeCaracter simbolo1, 4
        
        ;
        posicionar 8, 41
        imprimeCaracter simbolo1, 3
        
        ;
        posicionar 10, 39
        imprimeCaracter simbolo1, 2 
    endm
    
      ;Dibuja los simbolos del jugador 2
      
      simJug2 macro   
        posicionar 8, 35 ;fila columna
        imprimeCaracter simbolo2, 5
        
        ;cx 013Fh                  
        posicionar 8, 39
        imprimeCaracter simbolo2, 4
        
        ;
        posicionar 8, 41
        imprimeCaracter simbolo2, 3
        
        ;
        posicionar 10, 39
        imprimeCaracter simbolo2, 2 
      
      endm
    
    
    
;--------fin macros y procedimientos--------

    
;------Validacion de datos--------
    
    Start_Game: 
    imprime smsInicio1
    imprime smsInicio2
    imprime smsInicio3
    imprime smsInicio4
    imprime smsInicio5
    imprime smsInicio6
    imprime smsInicio7
    imprime smsInicio8
    imprime smsInicio9
    imprime smsInicio10
    imprime smsInicio11
    imprime smsInicio12
    imprime smsInicio13
    imprime smsInicio14
    imprime smsInicio15
    imprime smsInicio16
    imprime smsInicio17
    imprime smsInicio18
    imprime smsInicio19
    
    PantallaInicio:
        mov ah, 01h
        int 21h
        cmp al, 13
        je next
    loop PantallaInicio
    next:
    clearScreen
        
    ;Pide el nombre y simbolo de los jugadores
    imprime giveName1
    mov cx, 20
    mov di, 0 
    
    SaveJugador1:
        mov ah, 01h ;lee el caracter de la entrada estandar
        int 21h
        cmp al, 13 ; si hay un enter hace un salto condicional
        je escogerSimb1
        mov name1[di], al
        inc di
    loop SaveJugador1 
    
        escogerSimb1:
            printn ""
            printn ""
            imprime chooseSim
            mov di, 0
            mov ah, 01h
            int 21h
            mov simbolo1, al
            cmp al, 13
            je SaveJugador2
            mov simbolo1[di], al
            printn ""
            
            Jugador2:
            printn ""
            imprime giveName2
            mov si, 0
            je SaveJugador2
     
     SaveJugador2:
        mov ah, 01h
        int 21h
        cmp al, 13
        je escogerSimb2
        mov Name2[si],al
        inc si
     loop SaveJugador2
     
   escogerSimb2:
        printn ""
        printn ""
        imprime chooseSim 
        mov di, 0
        mov ah,01h   ;Lee el caracter de entrada estandar
        int 21h
        mov simbolo2, al
        cmp al,13             ;si hay un enter
        je Matriz          ;salte a la etiqueta
        printn ""

;-------Fin validacion de datos---------
 
;--------Imprime Matriz----------------
     
Level1 macro  
     
     Matriz:
     clearScreen
     
     printn ""
     imprime msj1
     imprime msj2
     imprime msj3
     printn ""
     print "El juego ha empezado            NIVEL 1"
     printn ""
     imprime salto
           
     imprime mtrz2
     imprime mtrz3
     imprime mtrz4
     imprime mtrz5
     imprime mtrz6
     imprime mtrz7
     imprime mtrz8
     
        
;----------imprime Nombres y Puntos------------------
                      
        imprime salto 
        print "Jugador 1, "    ;Muestra los nombres, puntos y simbolos de los jugadores
        imprime Name1
        
        print "Simbolo: "
        imprime simbolo1
          
        print "   Puntos: "
        posicionar 15, 53
        imprimeNumeros puntosJugador1
        
        
        imprime salto          ;imprime el salto
        
        
        print "Jugador 2, "
        imprime Name2
        
        print "Simbolo: "
        imprime simbolo2
        
        print "   Puntos: "
        posicionar 16, 53  
        imprimeNumeros puntosJugador2
        
        
        imprime salto
        imprime salto
        imprime salto
        imprime botones 
endm


Level2 macro
        
        
     clearScreen
     
     printn ""
     imprime msj1
     imprime msj2
     imprime msj3
     printn ""
     print "El juego ha empezado            NIVEL 2"
     printn ""
     imprime salto
      
     
     imprime mtrz2
     imprime mtrz3
     imprime mtrz4
     imprime mtrz5
     imprime mtrz6
     imprime mtrz7
     imprime mtrz8
     
        
;----------imprime Nombres y Puntos------------------
                      
        imprime salto 
        print "Jugador 1, "    ;Muestra los nombres, puntos y simbolos de los jugadores
        imprime Name1
        
        print "Simbolo: "
        imprime simbolo1
          
        print "   Puntos: "
        posicionar 15, 53
        imprimeNumeros puntosJugador1
        
        
        imprime salto          ;imprime el salto
        
        
        print "Jugador 2, "
        imprime Name2
        
        print "Simbolo: "
        imprime simbolo2
        
        print "   Puntos: "
        posicionar 16, 53  
        imprimeNumeros puntosJugador2
        
        
        imprime salto
        imprime salto
        imprime salto
        imprime botones 
        
endm
    
;llamamos la macro del nivel 1     
starts:
    Level1
       
                
;---------- limite de la matriz y Mouse -------------            
                            
        ;dibujamos los topos
        ;dx 0048h  cx 0127h
      
      
        cmp turnoJugadorX,0
        je turnoJ1
        jne turnoJ2
        turnoJ1: 
            simJug1;(macro) imprimimos el simbolo del jugador1
            jmp consultar 
        turnoJ2: 
            simJug2;(macro) imprimimos el simbolo del jugador2
            jmp consultar
        consultar:

        ;compara si la variables de tiempo de los topos llego a cero para ir a limpiar esa posicion
        
        
        cmp timeTopo1, 0
        je desaparecerTopo1
        
        cmp timeTopo2, 0
        je desaparecerTopo2
        
        cmp timeTopo3, 0
        je desaparecerTopo3
        
        cmp timeTopo4, 0  
        
        je desaparecerTopo4
        jne sig
        
        desaparecerTopo1:
            posicionar 8, 35
            imprime limpiar
            ;mov topo1, 0
            
        desaparecerTopo2:
            posicionar 8, 39
            imprime limpiar
            ;mov topo2, 0
        
        desaparecerTopo3:
            posicionar 8, 41
            imprime limpiar
            ;mov topo3, 0
            
        desaparecerTopo4:
            posicionar 10, 39
            imprime limpiar 
            ;mov topo4, 0
        ;si todas las variables llegan a ccero quiere dicer que ya no hay ningun simbolo en pantalla
            
        sig:
        
            cmp timeTopo1, 0
            je sigTopo2
            dec timeTopo1

        sigTopo2:
            cmp timeTopo2, 0
            je sigTopo3
            dec timeTopo2
        
        sigTopo3:
            cmp timeTopo3, 0
            je sigTopo4
            dec timeTopo3

        sigTopo4:
            cmp timeTopo4, 0
            je todoEnCero 
            dec timeTopo4
            jmp siguiente
        
        todoEnCero:
            
            cmp timeTopo1, 0
            je ver2
            jne siguiente
            ver2:
            cmp timeTopo2, 0
            je ver3
            jne siguiente
            ver3:
            cmp timeTopo3, 0
            je ver4
            jne siguiente
            ver4:
            cmp timeTopo4, 0
            je sigTurno
            jne siguienteNivel2
        
        sigTurno:  
            cmp turnoJugadorX, 1
            je  t2
            jne t1
            
            t2:
                    cmp pasadas, 2
                    je siguienteNivel2
                    
                    cmp atrapadoTopo1, 1
                    je eliminarz2
                    
                    posicionar 8, 35 ;fila columna
                    imprimeCaracter simbolo2, 5
                    
                    eliminarz2:
                    ;cx 013Fh
                     
                    cmp atrapadoTopo2, 1
                    je eliminarz3                 
                    posicionar 8, 39
                    imprimeCaracter simbolo2, 4
                    
                    eliminarz3:
                    ;   
                    
                    cmp atrapadoTopo3, 1
                    je eliminarz4
                    posicionar 8, 41
                    imprimeCaracter simbolo2, 3
                    
                    eliminarz4:
                    ;         
                    
                    cmp atrapadoTopo4, 1
                    je resetz
                    
                    posicionar 10, 39
                    imprimeCaracter simbolo2, 2
                    
                    
                    
                    resetz:
                            cmp atrapadoTopo1, 1
                            je siz2 
                            jne resetTimez
                        siz2:
                            cmp atrapadoTopo2, 1
                            je siz3 
                            jne resetTimez
                        siz3:
                            cmp atrapadoTopo3, 1
                            je siz4 
                            jne resetTimez
                            
                        siz4:   
                            cmp atrapadoTopo4, 1
                            je siguienteNivel2 
                            jne resetTimez
                    
                    resetTimez:
                        mov timeTopo1,19
                        mov timeTopo2,17
                        mov timeTopo3,20
                        mov timeTopo4,15
                    
                    
                    
                    inc pasadas
                    cmp pasadas, 2
                    je siguienteNivel2
                   
                    jmp siguiente
            t1:
            cmp pasadas, 2
            je siguienteNivel2
            
            cmp atrapadoTopo1, 1
            je eliminar2
            
            posicionar 8, 35 ;fila columna
            imprimeCaracter simbolo1, 5
            
            eliminar2:
            ;cx 013Fh
             
            cmp atrapadoTopo2, 1
            je eliminar3                 
            posicionar 8, 39
            imprimeCaracter simbolo1, 4
            
            eliminar3:
            ;   
            
            cmp atrapadoTopo3, 1
            je eliminar4
            posicionar 8, 41
            imprimeCaracter simbolo1, 3
            
            eliminar4:
            ;         
            
            cmp atrapadoTopo4, 1
            je reset
            
            posicionar 10, 39
            imprimeCaracter simbolo1, 2
            
            
            
            reset:
                    cmp atrapadoTopo1, 1
                    je si2 
                    jne resetTime
                si2:
                    cmp atrapadoTopo2, 1
                    je si3 
                    jne resetTime
                si3:
                    cmp atrapadoTopo3, 1
                    je si4 
                    jne resetTime
                    
                si4:   
                    cmp atrapadoTopo4, 1
                    je siguienteNivel2 
                    jne resetTime
            
            resetTime:
                mov timeTopo1,19
                mov timeTopo2,17
                mov timeTopo3,20
                mov timeTopo4,15
            
            
            
            inc pasadas
            cmp pasadas, 2
            je siguienteNivel2
           
            jmp siguiente
        
       ;falta 

        
        siguiente:
        
                                   ;(ya no es visible)
        mov ax,02h ; lo hacemos visible e indicamos esta etiqueta que nos sera de utilidad
        int 33h
        
        ; Con esta funcion obtenemos el clic con el que se hizo y las coordenadas en pixeles
        ; de donde anda el cursor
        
        mov ax,03h
        int 33h
    
        cmp bx,1    ; si se presiono clic izquierdo
        je comprobarTablero ; ve a una etiqueta que se llama comprobarTablero 
        cmp bx,2
        je comprobarTablero    ; si no compara ahora a ver si no es clic derecho
        
        jmp consultar 
        
        comprobarTablero:
        
                             ;Button
                            
                                  ; el valor de las lineas horizontales se van del registro cx a ax para dividirlos
        mov ax,cx           
        mov bl,8                 ; en bl se guarda el valor de 8 porque para hacer la conversion es necesario
        div bl                   ; se conoce como mickey el valor obtenido
        mov coordX,al            ; guardamos el valor de la division en coordX
       
        mov ax,dx                ; aplicamos el mismo proceso 
        mov bl,8                
        
        div bl
        mov coordY,al
        ; si es correcto ve a comprobar que este en la vertical igual
        
        
        cmp cx, 0111h 
        jl fueraTablero
        
        cmp cx, 015Fh
        jg fueraTablero
        
        cmp dx, 0038h
        jl fueraTablero
        
        cmp dx, 0070h
        jg fueraTablero
        
        ;compara si le dio a un topo
        cmp coordY, 08h
        je fila1 
        
        cmp coordY, 0Ah
        je fila2
        
        jmp consultar
;--------------- fin del limite de la matriz -------------------------------         
         
    
    
    ;comprueba si algun jugador dio click afuera de la matriz
    bip:
        beep
        
        cmp turnoJugadorX, 0
        je restarPts1
        jne restarPts2
        restarPts1:    ;se restan los puntos dependiendo del jugador en turno 
            sub puntosJugador1, 2
            posicionar 15, 53
            imprime limpiar
            posicionar 15, 53
            imprimeNumeros puntosJugador1
            
            jmp consultar       
        restarPts2:
            sub puntosJugador2, 2
            posicionar 16, 53
            imprime limpiar
            posicionar 16, 53
            imprimeNumeros puntosJugador2
                
            jmp consultar
            
        
            
        
    comprobarBotones:
        
        
        fila1:
            
            cmp coordX,023h
            je topoMorado
            
            cmp coordX,027h
            je topoRojo
            
            cmp coordX,029h
            je topoCeleste
            
            jmp consultar
            
        fila2: 
        
            cmp coordX, 027h
            je topoVerde
            
            
            
        
        fila3:
        
        
            ;los punto al atrapar los topos MORADO=10, ROJO=15, CELESTE=20, VERDE=25
            topoMorado: 
                cmp topo1, 0 ;si el topo ya no exsite suena el beep
                je bip
                
                mov topo1, 0
                mov atrapadoTopo1, 1
                
                cmp turnoJugadorX, 1
                je sumarJ2
                jne sumarJ1
                
                sumarJ1: 
                
                    add puntosJugador1, 10
                    posicionar 15, 53
                    imprime limpiar
                    posicionar 15, 53
                    imprimeNumeros puntosJugador1 
                    
                    jmp consultar
                
                SumarJ2:
                
                    add puntosJugador2, 10
                    posicionar 16, 53
                    imprime limpiar
                    posicionar 16, 53
                    imprimeNumeros puntosJugador2
                    
                    jmp consultar
                
                 
            topoRojo:
                cmp topo2, 0 ;si el topo ya no exsite suena el beep
                je bip
            
                mov topo2, 0
                mov atrapadoTopo2, 1
                cmp turnoJugadorX, 1
                je sumarRJ2
                jne sumarRJ1
                
                sumarRJ1: 
                
                    add puntosJugador1, 15
                    posicionar 15, 53
                    imprime limpiar
                    posicionar 15, 53
                    imprimeNumeros puntosJugador1 
                    
                    jmp consultar
                
                SumarRJ2:
                
                    add puntosJugador2, 15
                    posicionar 16, 53
                    imprime limpiar
                    posicionar 16, 53
                    imprimeNumeros puntosJugador2
                    
                    jmp consultar
            
            topoCeleste:
                cmp topo3, 0 ;si el topo ya no exsite suena el beep
                je bip
                
                mov topo3, 0
                mov atrapadoTopo3, 1
                cmp turnoJugadorX, 1
                je sumarCJ2
                jne sumarCJ1
                
                sumarCJ1: 
                
                    add puntosJugador1, 20
                    posicionar 15, 53
                    imprime limpiar
                    posicionar 15, 53
                    imprimeNumeros puntosJugador1 
                    
                    jmp consultar
                
                SumarCJ2:
                
                    add puntosJugador2, 20
                    posicionar 16, 53
                    imprime limpiar
                    posicionar 16, 53
                    imprimeNumeros puntosJugador2
                    
                    jmp consultar
            
            topoVerde:
                cmp topo4, 0 ;si el topo ya no exsite suena el beep
                je bip
                
                mov topo4, 0
                mov atrapadoTopo4, 1
                cmp turnoJugadorX, 1
                je sumarVJ2
                jne sumarVJ1
                
                sumarVJ1: 
                
                    add puntosJugador1, 25
                    posicionar 15, 53
                    imprime limpiar
                    posicionar 15, 53
                    imprimeNumeros puntosJugador1 
                    
                    jmp consultar
                
                SumarVJ2:
                
                    add puntosJugador2, 25
                    posicionar 16, 53
                    imprime limpiar
                    posicionar 16, 53
                    imprimeNumeros puntosJugador2
                    
                    jmp consultar
                         
        

    fueraTablero:
   
        beep
        cmp turnoJugadorX, 0
        je clickFueraJugador1
        jne clickFueraJugador2
                    
                    
                    
                               
        clickFueraJugador1:
        
            
            ;restamos 1 pto al jugador que clickeo fuera de la matriz                   
            sub puntosJugador1, 1
    
            posicionar 15, 53
            imprime limpiar   
            posicionar 15, 53
            imprimeNumeros puntosJugador1
            jmp consultar
            
        clickFueraJugador2:
                            
            ;restamos 1 pto al jugador que clickeo fuera de la matriz
            sub puntosJugador2, 1
            
            posicionar 8, 35
            imprime limpiar
            
            posicionar 16, 53
            imprime limpiar
             
            posicionar 16, 53
            imprimeNumeros puntosJugador2
            jmp consultar
                                               
                                               
                                               
                                               
                                               
                                               
                                               
;-------------------------INICIA EL SIGUIENTE NIVEL----------------------
       
siguienteNivel2:
Level2
    
    mov topo1,1
    mov topo2, 1
    mov topo3,  1
    mov topo4,   1
    
    mov topo5, 1
    mov topo6, 1 
    
    mov timeTopo1,19
    mov timeTopo2, 17
    mov timeTopo3,  20
    mov timeTopo4,   15 
    
    mov timeTopo5,  20
    mov timeTopo6,   15
    
    mov atrapadoTopo1, 0
    mov atrapadoTopo2,  0
    mov atrapadoTopo3,   0
    mov atrapadoTopo4,    0
    
    mov atrapadoTopo5,   0
    mov atrapadoTopo6,    0 
    mov pasadas,           0
    ;Level2
    
    ;---------- limite de la matriz y Mouse -------------            
                            
        ;dibujamos los topos
        ;dx 0048h  cx 0127h
      
        cmp turnoJugadorX,0
        je turnosJ1
        jne turnosJ2
        turnosJ1: 
            zimJug1;(macro) imprimimos el simbolo del jugador1
            jmp consultars 
        turnosJ2: 
            zimJug2;(macro) imprimimos el simbolo del jugador1
            jmp consultars    
        consultars:

        ;compara si la variables de tiempo de los topos llego a cero para ir a limpiar esa posicion
        
        
        cmp timeTopo1, 0
        je desaparecerTopos1
        
        cmp timeTopo2, 0
        je desaparecerTopos2
        
        cmp timeTopo3, 0
        je desaparecerTopos3
        
        cmp timeTopo4, 0  
        je desaparecerTopos4
        
        cmp timeTopo5, 0  
        je desaparecerTopos5
        
        cmp timeTopo6, 0   
        je desaparecerTopos6
        
        
        jne sigs
        
        desaparecerTopos1:
            posicionar 8, 35
            imprime limpiar
            ;mov topo1, 0
            
        desaparecerTopos2:
            posicionar 8, 39
            imprime limpiar
            ;mov topo2, 0
        
        desaparecerTopos3:
            posicionar 8, 41
            imprime limpiar
            ;mov topo3, 0
            
        desaparecerTopos4:
            posicionar 10, 35
            imprime limpiar
            
        desaparecerTopos5:
            posicionar 10, 39
            imprime limpiar
            
        desaparecerTopos6:
            posicionar 10, 41
            imprime limpiar 
            ;mov topo4, 0
        ;si todas las variables llegan a ccero quiere dicer que ya no hay ningun simbolo en pantalla
            
        sigs:
        
            cmp timeTopo1, 0
            je sigTopos2
            dec timeTopo1

        sigTopos2:
            cmp timeTopo2, 0
            je sigTopos3
            dec timeTopo2
        
        sigTopos3:
            cmp timeTopo3, 0
            je sigTopos4
            dec timeTopo3

        sigTopos4:
            cmp timeTopo4, 0
            je sigTopos5 
            dec timeTopo4
            
            
        sigTopos5:
            cmp timeTopo5, 0
            je sigTopos6 
            dec timeTopo5
            
            
        sigTopos6:
            cmp timeTopo6, 0
            je todoEnCeros 
            dec timeTopo6
            jmp siguientes
        
        todoEnCeros:
            
            cmp timeTopo1, 0
            je vers2
            jne siguientes
            
            vers2:
            cmp timeTopo2, 0
            je vers3
            jne siguientes
            
            vers3:
            cmp timeTopo3, 0
            je vers4
            jne siguientes
            
            vers4:
            cmp timeTopo4, 0
            je vers5
            jne siguientes
            
            vers5:
            cmp timeTopo5, 0
            je vers6
            jne siguientes
            
            vers6:
            cmp timeTopo6, 0
            je sigTurnos1
            
            jne siguienteNivels2;---------------------------------
        
        sigTurnos1:  
            :  
            cmp turnoJugadorX, 1
            je  tz2
            jne tz1
            
            tz2:    
                    cmp pasadas, 2
                    je siguienteNivels2
                    
                    cmp atrapadoTopo1, 1
                    je eliminarsz2
                    
                    posicionar 8, 35 ;fila columna
                    imprimeCaracter simbolo2, 5
                    
                    eliminarsz2:
                    ;cx 013Fh
                     
                    cmp atrapadoTopo2, 1
                    je eliminarsz3                 
                    posicionar 8, 39
                    imprimeCaracter simbolo2, 4
                    
                    eliminarsz3:
                    ;   
                    
                    cmp atrapadoTopo3, 1
                    je eliminarzs4
                    posicionar 8, 41
                    imprimeCaracter simbolo2, 3
                    
                    eliminarzs4:
                    ;         
                    
                    cmp atrapadoTopo4, 1
                    je eliminarzs5
                    
                    posicionar 10, 35
                    imprimeCaracter simbolo2, 2
                    
                    ;
                    eliminarzs5:
                    
                    cmp atrapadoTopo5, 1
                    je eliminarzs6
                    
                    posicionar 10, 39
                    imprimeCaracter simbolo2, 2
                    
                    ;
                    eliminarzs6:
                    
                    cmp atrapadoTopo6, 1
                    je resetsz
                    
                    posicionar 10, 41
                    imprimeCaracter simbolo2, 2
                    
                    
                    
                    resetsz:
                            cmp atrapadoTopo1, 1
                            je sisz2 
                            jne resetTimesz
                        sisz2:
                            cmp atrapadoTopo2, 1
                            je sisz3 
                            jne resetTimesz
                        sisz3:
                            cmp atrapadoTopo3, 1
                            je sisz4 
                            jne resetTimesz
                            
                        sisz4:
                            cmp atrapadoTopo4, 1
                            je sisz5 
                            jne resetTimesz
                                
                        sisz5:
                            cmp atrapadoTopo5, 1
                            je sisz6 
                            jne resetTimesz 
                            
                        sisz6:   
                            cmp atrapadoTopo6, 1
                            je siguienteNivels2 
                            jne resetTimesz
                                         
                    resetTimesz:
                        mov timeTopo1,19
                        mov timeTopo2,17
                        mov timeTopo3,20
                        mov timeTopo4,15
                        mov timeTopo5,20
                        mov timeTopo6,15
                    
                    
                    
                    inc pasadas
                    cmp pasadas, 2
                    je siguienteNivels2
                    
                    jmp siguientes
            
            tz1: 
            
                    cmp pasadas, 2
                    je siguienteNivels2
                    
                    cmp atrapadoTopo1, 1
                    je eliminars2
                    
                    posicionar 8, 35 ;fila columna
                    imprimeCaracter simbolo1, 5
                    
                    eliminars2:
                    ;cx 013Fh
                     
                    cmp atrapadoTopo2, 1
                    je eliminars3                 
                    posicionar 8, 39
                    imprimeCaracter simbolo1, 4
                    
                    eliminars3:
                    ;   
                    
                    cmp atrapadoTopo3, 1
                    je eliminars4
                    posicionar 8, 41
                    imprimeCaracter simbolo1, 3
                    
                    eliminars4:
                    ;         
                    
                    cmp atrapadoTopo4, 1
                    je eliminars5
                    
                    posicionar 10, 35
                    imprimeCaracter simbolo1, 2
                    
                    ;
                    eliminars5:
                    
                    cmp atrapadoTopo5, 1
                    je eliminars6
                    
                    posicionar 10, 39
                    imprimeCaracter simbolo1, 2
                    
                    ;
                    eliminars6:
                    
                    cmp atrapadoTopo6, 1
                    je resets
                    
                    posicionar 10, 41
                    imprimeCaracter simbolo1, 2
                    
                    
                    
                    resets:
                            cmp atrapadoTopo1, 1
                            je sis2 
                            jne resetTimes
                        sis2:
                            cmp atrapadoTopo2, 1
                            je sis3 
                            jne resetTimes
                        sis3:
                            cmp atrapadoTopo3, 1
                            je sis4 
                            jne resetTimes
                            
                        sis4:
                            cmp atrapadoTopo4, 1
                            je sis5 
                            jne resetTimes
                                
                        sis5:
                            cmp atrapadoTopo5, 1
                            je sis6 
                            jne resetTimes 
                            
                        sis6:   
                            cmp atrapadoTopo6, 1
                            je siguienteNivels2 
                            jne resetTimes
                                         
                    resetTimes:
                        mov timeTopo1,19
                        mov timeTopo2,17
                        mov timeTopo3,20
                        mov timeTopo4,15
                        mov timeTopo5,20
                        mov timeTopo6,15
                    
                    
                    
                    inc pasadas
                    cmp pasadas, 2
                    je siguienteNivels2
           
                    jmp siguientes
        
       ;falta 

        
        siguientes:
        
                                   ;(ya no es visible)
        mov ax,02h ; lo hacemos visible e indicamos esta etiqueta que nos sera de utilidad
        int 33h
        
        ; Con esta funcion obtenemos el clic con el que se hizo y las coordenadas en pixeles
        ; de donde anda el cursor
        
        mov ax,03h
        int 33h
    
        cmp bx,1    ; si se presiono clic izquierdo
        je comprobarTableros ; ve a una etiqueta que se llama comprobarTablero 
        cmp bx,2
        je comprobarTableros    ; si no compara ahora a ver si no es clic derecho
        
        jmp consultars 
        
        comprobarTableros:
        
                             ;Button
                            
                                  ; el valor de las lineas horizontales se van del registro cx a ax para dividirlos
        mov ax,cx           
        mov bl,8                 ; en bl se guarda el valor de 8 porque para hacer la conversion es necesario
        div bl                   ; se conoce como mickey el valor obtenido
        mov coordX,al            ; guardamos el valor de la division en coordX
       
        mov ax,dx                ; aplicamos el mismo proceso 
        mov bl,8                
        
        div bl
        mov coordY,al
        ; si es correcto ve a comprobar que este en la vertical igual
        
        
        cmp cx, 0111h 
        jl fueraTableros
        
        cmp cx, 015Fh
        jg fueraTableros
        
        cmp dx, 0038h
        jl fueraTableros
        
        cmp dx, 0070h
        jg fueraTableros
        
        ;compara si le dio a un topo
        cmp coordY, 08h
        je filas1 
        
        cmp coordY, 0Ah
        je filas2
        
        jmp consultars
;--------------- fin del limite de la matriz -------------------------------         
         
    
    
    ;comprueba si algun jugador dio click afuera de la matriz
    bips:
        beep
        
        cmp turnoJugadorX, 0
        je restarPtss1
        jne restarPtss2
        restarPtss1:    ;se restan los puntos dependiendo del jugador en turno 
            sub puntosJugador1, 2
            posicionar 15, 53
            imprime limpiar
            posicionar 15, 53
            imprimeNumeros puntosJugador1
            
            jmp consultars       
        restarPtss2:
            sub puntosJugador2, 2
            posicionar 16, 53
            imprime limpiar
            posicionar 16, 53
            imprimeNumeros puntosJugador2
                
            jmp consultars
            
        
            
        
    comprobarBotoness:
        
        
        filas1:
            
            cmp coordX,023h
            je topoMorados
            
            cmp coordX,027h
            je topoRojos
            
            cmp coordX,029h
            je topoCelestes
            
            
            
            jmp consultars
            
        filas2: 
        
            cmp coordX, 027h
            je topoVerdes
            
            cmp coordX, 023h
            je topoAbajoMorado
            
            cmp coordX, 029h
            je topoAbajoRojo
            
            
            
            
            
        
        filas3:
        
        
            ;los punto al atrapar los topos MORADO=10, ROJO=15, CELESTE=20, VERDE=25
            topoMorados: 
                cmp topo1, 0 ;si el topo ya no exsite suena el beep
                je bips
                
                mov topo1, 0
                mov atrapadoTopo1, 1
                cmp turnoJugadorX, 1
                je sumarsJ2
                jne sumarsJ1
                
                sumarsJ1: 
                
                    add puntosJugador1, 10
                    posicionar 15, 53
                    imprime limpiar
                    posicionar 15, 53
                    imprimeNumeros puntosJugador1 
                    
                    jmp consultars
                
                SumarsJ2:
                
                    add puntosJugador2, 10
                    posicionar 16, 53
                    imprime limpiar
                    posicionar 16, 53
                    imprimeNumeros puntosJugador2
                    
                    jmp consultars
                
                 
            topoRojos:
                cmp topo2, 0 ;si el topo ya no exsite suena el beep
                je bips
            
                mov topo2, 0
                mov atrapadoTopo2, 1
                cmp turnoJugadorX, 1
                je sumarsRJ2
                jne sumarsRJ1
                
                sumarsRJ1: 
                
                    add puntosJugador1, 10
                    posicionar 15, 53
                    imprime limpiar
                    posicionar 15, 53
                    imprimeNumeros puntosJugador1 
                    
                    jmp consultars
                
                SumarsRJ2:
                
                    add puntosJugador2, 10
                    posicionar 16, 53
                    imprime limpiar
                    posicionar 16, 53
                    imprimeNumeros puntosJugador2
                    
                    jmp consultars
            
            topoCelestes:
                cmp topo3, 0 ;si el topo ya no exsite suena el beep
                je bips
                
                mov topo3, 0
                mov atrapadoTopo3, 1
                cmp turnoJugadorX, 1
                je sumarsCJ2
                jne sumarsCJ1
                
                sumarsCJ1: 
                
                    add puntosJugador1, 15
                    posicionar 15, 53
                    imprime limpiar
                    posicionar 15, 53
                    imprimeNumeros puntosJugador1 
                    
                    jmp consultars
                
                SumarsCJ2:
                
                    add puntosJugador2, 15
                    posicionar 16, 53
                    imprime limpiar
                    posicionar 16, 53
                    imprimeNumeros puntosJugador2
                    
                    jmp consultars
            
            topoVerdes:
                cmp topo6, 0 ;si el topo ya no exsite suena el beep
                je bips
                
                mov topo6, 0
                mov atrapadoTopo6, 1
                cmp turnoJugadorX, 1
                je sumarsVJ2
                jne sumarsVJ1
                
                sumarsVJ1: 
                
                    add puntosJugador1, 20
                    posicionar 15, 53
                    imprime limpiar
                    posicionar 15, 53
                    imprimeNumeros puntosJugador1 
                    
                    jmp consultars
                
                SumarsVJ2:
                
                    add puntosJugador2, 20
                    posicionar 16, 53
                    imprime limpiar
                    posicionar 16, 53
                    imprimeNumeros puntosJugador2
                    
                    jmp consultars
                             
            topoAbajoRojo:
                cmp topo5, 0 ;si el topo ya no exsite suena el beep
                je bips
                
                mov topo5, 0
                mov atrapadoTopo5, 1
                cmp turnoJugadorX, 1
                je sumarsRJ2
                jne sumarsRJ1
                
            
            topoAbajoMorado:
                cmp topo6, 0 ;si el topo ya no exsite suena el beep
                je bips
                
                mov topo4, 0
                mov atrapadoTopo4, 1
                cmp turnoJugadorX, 1
                je sumarsJ2
                jne sumarsJ1             
        
        
        
        
        
        
    
    fueraTableros:
   
        beep
        cmp turnoJugadorX, 0
        je clickFueraJugadors1
        jne clickFueraJugadors2
                    
                    
                    
                               
        clickFueraJugadors1:
        
            
            ;restamos 1 pto al jugador que clickeo fuera de la matriz                   
            sub puntosJugador1, 1
    
            posicionar 15, 53
            imprime limpiar   
            posicionar 15, 53
            imprimeNumeros puntosJugador1
            jmp consultars
            
        clickFueraJugadors2:
                            
            ;restamos 1 pto al jugador que clickeo fuera de la matriz
            sub puntosJugador2, 1
            
            posicionar 8, 35
            imprime limpiar
            
            posicionar 16, 53
            imprime limpiar
             
            posicionar 16, 53
            imprimeNumeros puntosJugador2
            jmp consultars
    
    
     

siguienteNivels2: 
    add turnoJugadorX, 1
    cmp turnoJugadorX, 2
    je final
    mov topo1,1
    mov topo2, 1
    mov topo3,  1
    mov topo4,   1
    mov topo5,  1
    mov topo6,   1
    
    mov timeTopo1,19
    mov timeTopo2, 17
    mov timeTopo3,  20
    mov timeTopo4,   15
    mov timeTopo5,  20
    mov timeTopo6,   15 
    
    mov atrapadoTopo1, 0
    mov atrapadoTopo2,  0
    mov atrapadoTopo3,   0
    mov atrapadoTopo4,    0
    mov atrapadoTopo5,   0
    mov atrapadoTopo6,    0 
    mov pasadas,           0
    
jmp starts
    final:
    
    printn "end game"
        

        
        define_print_string
        define_print_num
        define_print_num_uns
        .exit            
