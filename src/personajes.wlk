import wollok.game.*
import juego.*
import numeros.*

object bombero {
	var property image = "bombero.png"
	var property position = game.at(1,1)
	var property jugadorVaGanando = true
	var property puntaje=0
	
	
	method posicion() = position
	method subir(){self.moverse(position.up(1))}
	method bajar(){self.moverse(position.down(1))}
	method izquierda(){self.moverse(position.left(1))}
	method derecha(){self.moverse(position.right(1))}
	
	method moverse(pos){ if(!mapa.esUnaPared(pos)) { position = pos } }

	method sumarPuntaje(){
		puntaje=puntaje+1
	    new Puntaje(posUnidad = 4,posDecena=3).informarNumero(self.puntaje())
	    if (puntaje==20){game.clear()  game.addVisual(bombero)game.say(bombero," GANASTE ")
			
	    }	
	}	
	
	method puntaje()=puntaje
	method lanzarAgua(){
		var aguas=[]
		game.addVisual(new Agua())
	}
	}
	object fin{
		const property position=game.origin()
		const property image= "gameOver.jpg"
	}
	