import wollok.game.*
import personajes.*
import juego.*

/*
class Agua {
	var property image="agua.png"
	var property position=bombero.position().right(1)
	
}
*/

object agua {
	var property image="agua.png"
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
}

class Fuego {
	//Checkear que el fuego no aparezca en otro objeto
	
	//var property cantFuego=0
	var property image="fuego.png"
	var property position=game.at(1.randomUpTo(11),1.randomUpTo(11))
	
	method teAgarre()=game.removeVisual(self)
	method aparecer() {
		game.addVisual(self)
		juego.aumentarFuego()
		juego.prendidoFuego()
	}
	method mojarse() {
		bombero.sumarPuntaje()
		game.removeVisual(self)
		juego.disminuirFuego()
	}
}

class Obstaculo {
	var property image="stone.png"
	var property position
	
	method mojarse() {}
	
}