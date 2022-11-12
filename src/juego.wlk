import wollok.game.*
import personajes.*
import numeros.*
import objetos.*
import mapa.*
import direcciones.*

object juego {
	var property juegoIniciado = false
	var property cantidadFuego = 0
	
	method iniciar() {
		game.title("fire fighters")
		game.width(13)
		game.height(13)

		game.boardGround("fondo.png")
		game.addVisual(pantallaPierdeUnaVida)
		game.addVisualIn(pantallaDeInicio,game.at(0,0))
		pantallaDeInicio.iniciarAnimacion()
		keyboard.enter().onPressDo({instrucciones.mostrarIntrucciones()})
		
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
		if (not juegoIniciado) {
			game.removeVisual(pantallaDeInicio)
			juegoIniciado = true
			self.bomberoControles()
			pantallaDeInicio.terminarAnimacion()
			game.addVisual(time)
			game.addVisual(puntaje)
			mapa.agregarPosicionesIniciales()
			mapa.objetosEnMapa().forEach({o=>game.addVisual(o)})
			game.schedule(1000,{game.onTick(1000,"tiempo",{reloj.disminuir()})})
			game.schedule(1000, {game.onTick(1500,"Aparece nuevo fuego",{self.aparecerFuego()})})
			/*
			 * El onTick de abajo no es para nada importante, solo vuelve a agregar la imagen del bombero para que la imagen de los fuegos
			 * y obstaculos nuevos no queden por encima de la imagen del bombero, se puede sacar tranquilamente
			 */
			game.onTick(1000, "", {game.removeVisual(bombero) game.addVisual(bombero)})
			game.onCollideDo(bombero,({obj=>obj.choca()}))
			gameOver.salirDelJuego()
			gameOver.volverAlInicio()
		}
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
	method aparecerObstaculo() {
		var pos = game.at(1.randomUpTo(12).truncate(0),1.randomUpTo(12).truncate(0))
		if (not mapa.hayObstaculo(pos) and not mapa.hayFuego(pos)) {
			mapa.agregarObstaculo(new Obstaculo(position = pos))
			mapa.objetosEnMapa().last().aparecer()
		} else {
			self.aparecerObstaculo()
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

object instrucciones {
	var seMuestra = true
	const property position = game.origin()
	const property image = "instrucciones.jpg"
	
	method mostrarIntrucciones() {
		if(seMuestra)
			seMuestra = true
			game.addVisual(self)
			game.schedule(3000, { game.removeVisual(self)
			juego.empezar()	})
	}
}

object pantallaPierdeUnaVida {
	const property position= game.origin()
	var property image = "blank.png"

	method sePoneLaPantallaRoja() {
		image = "fondoRojo.png"
		mapa.objetosEnMapa().forEach({o=>o.cambiarImagen()})
		game.schedule(200,{image = "blank.png"})
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
		self.salirDelJuego()
		self.volverAlInicio()
	}
	
	method salirDelJuego() {keyboard.q().onPressDo({game.stop()})}
	method volverAlInicio() {keyboard.backspace().onPressDo({self.restartGame()})}
	method restartGame() {
		game.clear()
		mapa.borrarTodo()
		juego.juegoIniciado(false)
		juego.cantidadFuego(0)
		reloj.tiempo(40)
		bombero.vidas(3)
		bombero.position(game.at(1,1))
		bombero.puntaje(0)
		bombero.image("bomberoEste.png")
		bombero.direccion(este)
		juego.iniciar()
		}
	method musica()
	method mensajeBombero()
	method image()
	
}

object gameOver inherits Fin {
	
	override method musica() {game.sound("perder.mp3").play()} 
	override method mensajeBombero() {game.say(bombero,"Perdiste")} 
	override method image() = "GameOver.png"
}

object youWin inherits Fin {
	override method musica() {game.sound("ganó.mp3").play()} 
	override method mensajeBombero() {game.say(bombero,"Ganaste!")} 
	override method image() = "fondoGanador.png"
}
