import wollok.game.*
import personajes.*
import juego.*
import mapa.*
import numeros.*
import direcciones.*


object agua {
	var property image="aguaHorizontal.png"
	var property position
	
	method manguerear() {
		game.onCollideDo(self,{fuego=>fuego.mojarse() })
	}
	method aparecer(pos, dir) {
		position = dir.direccionPosition(pos)
		image = dir.imageAgua()
		game.addVisual(self)
		game.sound("chorroAgua.mp3").play()
		game.schedule(250,{game.removeVisual(self)})
		self.manguerear()
	}
	method choca() {}
	method mojarse() {}
}

class Fuego {
	var property image="fuego.png"
	var property position
	
	method aparecer() {
		game.addVisual(self)
		juego.aumentarFuego()
		juego.prendidoFuego()
	}
	method mojarse() {
		juego.disminuirFuego()
		mapa.quitarFuego(self)
		game.removeVisual(self)
		bombero.sumarPuntaje()
	}
	method choca() {
		juego.disminuirFuego()
		mapa.quitarFuego(self)
		game.removeVisual(self)
		bombero.seQuema()
	}
}

class Obstaculo {
	var property image="obstaculo.png"
	var property position
	const direcciones = [norte,sur,este,oeste]
	
	method aparecer() {
		game.addVisual(self)
	}
	method mojarse() {}
	method choca() {}
	method direccionRandom() {
		var random = 0.randomUpTo(4).truncate(0)
		var coordenadas
		
		if (random != 4) {
			coordenadas = direcciones.get(random).direccionPosition(self.position())
		} else { self.direccionRandom() }
		return coordenadas
	}
	method expandir() {
		var coordenadas = self.direccionRandom()
		if (mapa.hayObstaculo(coordenadas) or mapa.hayFuego(coordenadas)) {
			self.expandir()
		}
		return coordenadas
	}
	method cambiarImagen() {
		image="obstaculoRojo.png"
		game.schedule(200, {image="obstaculo.png"})
	}
}
object reloj {
	  var property tiempo=40
	 
	  method disminuir() {
	  	
		tiempo=0.max(tiempo-1)
	    new Numero(posUnidad = 4,posDecena=3,posY=12).informarNumero(self.tiempo())
		if (tiempo==25) {
			mapa.agregarNuevosObstaculos()
		}
	    if (tiempo==0) {
	    	gameOver.finalizar()
	    }
	}
}

object time {
	var property image="tiempo.png"
	var property position=game.at(1,12)
}

object puntaje {
	var property image="puntos.png"
	var property position=game.at(1,0)
}
