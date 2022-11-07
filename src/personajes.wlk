import wollok.game.*
import juego.*
import numeros.*
import direcciones.*
import objetos.*
import mapa.*


object bombero {
	var property image = "bomberoEste.png"
	var property position = game.at(1,1)
	var property jugadorVaGanando = true
	var property puntaje=0
	var vidas = 3
	var direccion = este
	
	
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
	    new Puntaje(posUnidad = 4,posDecena=3).informarNumero(self.puntaje())
	    if (puntaje==20) {
	    	youWin.finalizar()
	    }
	}
	
	method puntaje() = puntaje
	method lanzarAgua() {
		agua.aparecer(position, direccion)
	}
}

