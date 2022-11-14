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
	    if (puntaje == 5 || puntaje == 10) {
	    	chicoAlerta.diceMensaje(15-puntaje)
	   		}
	    if (puntaje==15) {
	    	youWin.finalizar()
	    }
	}
	
	method puntaje() = puntaje
	method lanzarAgua() {
		agua.aparecer(position, direccion)
	}
	method cambiarImagen() {}
	
}

object chicoAlerta {
	var property image = "chico.png"
	var property position = game.at(1,1)
	
	method diceMensaje(puntos) {
		game.addVisual(self)
		game.sound("grito.mp3").play()
		game.say(self,"Faltan " + puntos + " fuegos por apagar!!")
		game.schedule(2000,{game.removeVisual(self)})
	}
	method mojarse() {}
	method choca() {}
}