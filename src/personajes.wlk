import wollok.game.*
import juego.*
import numeros.*
import direcciones.*
import objetos.*
import mapa.*


object bombero {
	var property image = "bomberoSur.png"
	var property position = game.at(6,11)
	var property puntaje=0
	var property vidas = 3
	var property direccion = sur
	
	
	method posicion() = position
	method subir() {self.moverse(position.up(1), norte)}
	method bajar() {self.moverse(position.down(1), sur)}
	method izquierda() {self.moverse(position.left(1), oeste)}
	method derecha() {self.moverse(position.right(1), este)}
	
	method moverse(pos, dir) {
		if(dir.esValida(pos) and not mapa.hayObstaculo(pos)) {
			position = pos
			direccion = dir
			image = dir.imageBombero()
		}
	}
	method mojarse() {}
	method seQuema() {
		vidas--
		if (vidas > 0) {
			game.sound("Ouch!.mp3").play()
			game.say(self,"Ouch! Me quedan = " + vidas + " vidas")
			pantallaPierdeUnaVida.sePoneLaPantallaRoja()
		} else {
			gameOver.finalizar()
		}
	}

	method sumarPuntaje() {
		puntaje++
	    new Numero(posUnidad = 4,posDecena=3,posY=0).informarNumero(self.puntaje())
	    if (puntaje==20) {
	    	youWin.finalizar()
	    }
	}
	
	method puntaje() = puntaje
	method lanzarAgua() {
		agua.aparecer(position, direccion)
	}
	method cambiarImagen() {}
}

