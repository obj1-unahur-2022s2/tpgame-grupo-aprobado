import wollok.game.*
import personajes.*
import juego.*
import objetos.*



class Numero {
	var numeros = ["cero.png","uno.png","dos.png","tres.png","cuatro.png","cinco.png","seis.png","siete.png","ocho.png","nueve.png"]
	var posUnidad
	var posDecena
	 var posY
	
	method informarNumero(numero) {
		var unidad = numero % 10
		var decena = numero.div(10)
		self.dibujarNumero( self.obtenerNombreDeNumero(unidad) , posUnidad,posY)
		self.dibujarNumero( self.obtenerNombreDeNumero(decena) , posDecena,posY)
	}
	
	method dibujarNumero(nombreNumero,parteDeNumero,pos) {
		var nuevoNumero = new ElementoVisual(image=nombreNumero, position=game.at(parteDeNumero,pos))
		nuevoNumero.dibujarElemento()
	}
	
	method obtenerNombreDeNumero(numero) {
		return numeros.get(numero)
	}
}

class ElementoVisual {
	var property image
	var property position
	
	method dibujarElemento() {
		game.addVisual(self)
	}
}



