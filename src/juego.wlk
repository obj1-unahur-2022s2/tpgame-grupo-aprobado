import wollok.game.*
import personajes.*
import numeros.*
import objetos.*
import mapa.*

/*
 * Agregar contador de vidas
 * Agregar metodos a "bombero" y "direcciones" para que el sprite del bombero cambie dependiendo de la direccion
 * Corroborar que los objetos de la clase "Fuego" no aparezcan en un casillero ocupado por el jugador o por otro fuego
 * 
 * Esto ya es para mas adelante, pero estaria copado agregar un menu, accesible con la tecla "Esc" para salir del juego sin tener que cerrar la ventana
 */

object juego {
	var juegoIniciado = false
	var cantidadFuego = 0
	
	method iniciar() {
		game.title("fire fighters")
		game.width(13)
		game.height(13)	
		//mapa.agregarPosiciones()

		game.boardGround("fondo.png")
		game.addVisualIn(pantallaDeInicio,game.at(0,0))
		pantallaDeInicio.iniciarAnimacion()
		keyboard.enter().onPressDo({self.empezar()})
		
	}
	
	method bomberoControles() {
		keyboard.up().onPressDo({bombero.subir()})
		keyboard.down().onPressDo({bombero.bajar()})
		keyboard.left().onPressDo({bombero.izquierda()})
		keyboard.right().onPressDo({bombero.derecha()})
		keyboard.space().onPressDo({bombero.lanzarAgua()})
		
		game.addVisual(bombero)
		
	}
	
	method empezar(){
		if (not juegoIniciado) {
			game.removeVisual(pantallaDeInicio)
			juegoIniciado = true
			self.bomberoControles()
			pantallaDeInicio.terminarAnimacion()
			game.addVisual(time)
			game.addVisual(puntaje)
			mapa.agregarPosiciones()
			mapa.posProhibidas().forEach({o=>game.addVisual(o)})
			game.schedule(2000,{game.onTick(1000,"tiempo",{reloj.disminuir()})})
			//new Fuego().aparecer()
			
			game.onTick(1500,"Aparece nuevo fuego",{new Fuego().aparecer()})
			
			game.onCollideDo(bombero,{f=>bombero.seQuema()})
			game.onCollideDo(bombero,({f=>game.removeVisual(f)}))
		//	game.sound("comienzo.mp3").play()
		//	game.onCollideDo(
		}
	}
	
	method aumentarFuego() { cantidadFuego++ }
	method disminuirFuego() { cantidadFuego-- }
	method prendidoFuego() {
		if (cantidadFuego == 5) {
			fin.gameOver()
		}
	}
	/*
	method forzarDesaparicionEn(pos) {
		game.getObjectsIn(pos).forEach{unObjeto=>unObjeto.forzarDesaparicion()}
	}
	*/
}

object pantallaDeInicio {
	var imagen = false
	
	method iniciarAnimacion() {
		game.onTick(250,"Animacion del menu",{self.cambiar()})
	}
	method terminarAnimacion() {
		game.removeTickEvent("Animacion del menu")
	}
	method cambiar() {
		if(imagen)
			imagen = false
		else
			imagen = true
	}
	
	method image() {
		if(imagen)
			return "inicio.png"
		else
			return "inicio1.jpg"
	}
}

object pantallaPierdeUnaVida {
	const property position= game.origin()
	const property image= "fondoRojo.png"
	
	method sePoneLaPantallaRoja() {
		game.addVisual(self)
		game.schedule(200,{game.removeVisual(self)})
	}
	
}

//Revisar objeto /fin/, quizas se pueda remover y agregar el metodo /gameOver/ directamente al objeto juego
object fin {
	const property position=game.origin()
	var property image= "gameOver.png"
	
	method gameOver() {
		self.position()
		game.sound("perder.mp3").play()
		game.clear()
		game.addVisual(self)
		bombero.position(game.at(6,2))
		bombero.image("bomberoSur.png")
		game.addVisual(bombero)
		game.say(bombero,"Perdiste")
	}
	
	method youWin() {
		self.position()
		image = "fondoGanador.png"
		game.sound("ganó.mp3").play()
		game.clear()
		game.addVisual(self)
		bombero.position(game.at(6,2))
		bombero.image("bomberoSur.png")
		game.addVisual(bombero)
		game.say(bombero,"Ganaste!")
	}
}
