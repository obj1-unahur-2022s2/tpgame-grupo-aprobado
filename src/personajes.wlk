import wollok.game.*
import juego.*

object bombero {
	var property image = "bombero.png"
	var property position = game.at(1,1)
	var property jugadorVaGanando = true
	
	method posicion() = position
	method subir(){self.moverse(position.up(1))}
	method bajar(){self.moverse(position.down(1))}
	method izquierda(){self.moverse(position.left(1))}
	method derecha(){self.moverse(position.right(1))}
	
	method moverse(pos){ if(!mapa.esUnaPared(pos)) { position = pos } }
}