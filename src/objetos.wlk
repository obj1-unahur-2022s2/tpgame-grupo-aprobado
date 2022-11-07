import wollok.game.*
import personajes.*
import juego.*
import mapa.*


object agua {
	var property image="aguaHorizontal.png"
	var property position
	
	method manguerear() {
		game.onCollideDo(self,{fuego=>fuego.mojarse() })
	}
	method aparecer(pos, dir) {
		position = dir.aguaPosition(pos)
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
	
	method teAgarre()=game.removeVisual(self)
	method aparecer() {
		game.addVisual(self)
		juego.aumentarFuego()
		juego.prendidoFuego()
	}
	method mojarse() {
		bombero.sumarPuntaje()
		juego.disminuirFuego()
		mapa.quitarFuego(self)
		game.removeVisual(self)
	}
	method choca() {
		bombero.seQuema()
		juego.disminuirFuego()
		mapa.quitarFuego(self)
		game.removeVisual(self)
	}
}

class Obstaculo {
	var property image="stone.png"
	var property position
	
	method aparecer() {}
	method mojarse() {}
	method choca() {}
}

