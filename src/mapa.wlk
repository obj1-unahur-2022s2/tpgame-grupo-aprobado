import wollok.game.*
import personajes.*
	
class Ventana {
	var property alto = 0
	var property ancho = 0
	var estaQuemada = false
	
	method position() = game.at(alto, ancho) 
	method quemarse() { estaQuemada = true }
	method apagarse() { estaQuemada = false }
	
}


object mapa {
	const posProhibidas = [game.at(1,1), game.at(1,2), game.at(1,3), game.at(1,4), game.at(2,1), game.at(2,2), game.at(2,3), game.at(2,4)]
	const ventanas = [new Ventana(alto = 3, ancho = 1), new Ventana(alto = 3, ancho = 2), new Ventana(alto = 3, ancho = 3), new Ventana(alto = 3, ancho = 4),
					new Ventana(alto = 4, ancho = 1), new Ventana(alto = 4, ancho = 2), new Ventana(alto = 4, ancho = 3), new Ventana(alto = 4, ancho = 4),
					new Ventana(alto = 5, ancho = 1), new Ventana(alto = 5, ancho = 2), new Ventana(alto = 5, ancho = 3), new Ventana(alto = 5, ancho = 4),
					new Ventana(alto = 6, ancho = 1), new Ventana(alto = 6, ancho = 2), new Ventana(alto = 6, ancho = 3), new Ventana(alto = 6, ancho = 4)]
	
	
	method hayVentana(position) = position.x() == ventanas.any({v => v.alto()}) and position.y() == ventanas.any({v => v.ancho()})
	
	method ventana(position) =  ventanas.filter({v => v.alto() == position.x() and v.ancho() == position.y()})
	
	method ventanaEstaQuemada(position) = self.hayVentana(position) and ventanas.filter({v => v.alto() == position.x() and v.ancho() == position.y()}).estaQuemada()
}




