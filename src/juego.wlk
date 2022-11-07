import wollok.game.*
import personajes.*
import numeros.*
import objetos.*
import mapa.*

/*
 * Agregar contador de vidas
 * 
 * Esto ya es para mas adelante, pero estaria copado agregar un menu, accesible con la tecla "Esc" para salir del juego sin tener que cerrar la ventana
 */

object juego {
	//var juegoIniciado = false
	var cantidadFuego = 0
	
	method iniciar() {
		game.title("fire fighters")
		game.width(13)
		game.height(13)

		game.boardGround("fondo.png")
		game.addVisualIn(pantallaDeInicio,game.at(0,0))
		pantallaDeInicio.iniciarAnimacion()
		keyboard.enter().onPressDo({self.empezar()})
		
	}
	
	method bomberoControles() {
		keyboard.up().onPressDo({bombero.subir()})
		keyboard.w().onPressDo({bombero.subir()})
		keyboard.down().onPressDo({bombero.bajar()})
		keyboard.s().onPressDo({bombero.bajar()})
		keyboard.left().onPressDo({bombero.izquierda()})
		keyboard.a().onPressDo({bombero.izquierda()})
		keyboard.right().onPressDo({bombero.derecha()})
		keyboard.d().onPressDo({bombero.derecha()})
		keyboard.space().onPressDo({bombero.lanzarAgua()})
	}
	
	method empezar(){
		//if (not juegoIniciado) {
			game.removeVisual(pantallaDeInicio)
			//juegoIniciado = true
			self.bomberoControles()
			pantallaDeInicio.terminarAnimacion()
			game.addVisual(time)
			game.addVisual(puntaje)
			mapa.agregarPosiciones()
			mapa.objetosEnMapa().forEach({o=>game.addVisual(o)})
			game.schedule(1000,{game.onTick(1000,"tiempo",{reloj.disminuir()})})
			game.schedule(1000, {game.onTick(1500,"Aparece nuevo fuego",{self.aparecerFuego()})})
			game.onCollideDo(bombero,({obj=>obj.choca()}))
		//}
	}
	
	method aparecerFuego() {
		var pos = game.at(1.randomUpTo(12).truncate(0),1.randomUpTo(12).truncate(0))
		if (not mapa.hayObstaculo(pos) and not mapa.hayFuego(pos)) {
			mapa.agregarFuego(new Fuego(position = pos))
			mapa.fuegosEnMapa().last().aparecer()
		} else {
			self.aparecerFuego()
		}
	}
	method aumentarFuego() { cantidadFuego++ }
	method disminuirFuego() { cantidadFuego-- }
	method prendidoFuego() {
		if (cantidadFuego == 5) {
			gameOver.finalizar()
		}
	}
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

class Fin {
	const property position = game.origin()
	
	method finalizar() {
		self.position()
		game.clear()
		game.addVisual(self)
		bombero.position(game.at(6,2))
		bombero.image("bomberoSur.png")
		game.addVisual(bombero)
		self.musica()
		self.mensajeBombero()
	}
	
	method musica()
	method mensajeBombero()
	method image()
	
}

object gameOver inherits Fin {
	
	override method musica() {game.sound("perder.mp3").play()} 
	override method mensajeBombero() {game.say(bombero,"Perdiste")} 
	override method image() = "gameOver.png"
}

object youWin inherits Fin {
	override method musica() {game.sound("ganó.mp3").play()} 
	override method mensajeBombero() {game.say(bombero,"Ganaste!")} 
	override method image() = "fondoGanador.png"
}
