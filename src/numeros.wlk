import wollok.game.*
import personajes.*
import juego.*

class Puntaje {
	var numeros = ["cero.png","uno.png","dos.png","tres.png","cuatro.png","cinco.png","seis.png","siete.png","ocho.png","nueve.png"]
	var posUnidad
    var posDecena
	
	method informarNumero(numero){
		var unidad = numero % 10
		var decena = numero.div(10)
		self.dibujarNumero( self.obtenerNombreDeNumero(unidad) , posUnidad)
		self.dibujarNumero( self.obtenerNombreDeNumero(decena) , posDecena)
	}
	
	method dibujarNumero(nombreNumero,parteDeNumero){
		var nuevoNumero = new ElementoVisual(image=nombreNumero, position=game.at(parteDeNumero,0))
		nuevoNumero.dibujarElemento()
	}
	
	method obtenerNombreDeNumero(numero){
		return numeros.get(numero)
	}
}
class Numero {
	var numeros = ["cero.png","uno.png","dos.png","tres.png","cuatro.png","cinco.png","seis.png","siete.png","ocho.png","nueve.png"]
	var posUnidad
	var posDecena
	
	method informarNumero(numero){
		var unidad = numero % 10
		var decena = numero.div(10)
		self.dibujarNumero( self.obtenerNombreDeNumero(unidad) , posUnidad)
		self.dibujarNumero( self.obtenerNombreDeNumero(decena) , posDecena)
	}
	
	method dibujarNumero(nombreNumero,parteDeNumero){
		var nuevoNumero = new ElementoVisual(image=nombreNumero, position=game.at(parteDeNumero,12))
		nuevoNumero.dibujarElemento()
	}
	
	method obtenerNombreDeNumero(numero){
		return numeros.get(numero)
	}
}
class ElementoVisual {
	var property image
	var property position
	
	method dibujarElemento(){
		game.addVisual(self)
	}
	
	method borrarElemento(){
		game.removeVisual(self)
	}
} 
object reloj{
	  var property tiempo=40
	 
	  method disminuir(){
	  	
		tiempo=0.max(tiempo-1)
	    new Numero(posUnidad = 5,posDecena=4).informarNumero(self.tiempo())
	
	    if (tiempo==0){game.clear()  game.addVisual(bombero)game.say(bombero,"perdiste")}	
		
	      
	}
}
class Fuego{
	var property cantFuego=0
	var property image="fuego.png"
	var property position=game.at(1.randomUpTo(11),1.randomUpTo(11))
	method teAgarre()=game.removeVisual(self)
	method aparecer(){ game.onTick(1000,"fuego",{game.addVisual(new Fuego())}) 
		cantFuego=cantFuego+1}
	method prendidoFuego(){if (cantFuego==5){game.clear()  
		game.addVisual(bombero)game.say(bombero,"perdiste")
		
	}}	               	
		   
						
}
object time{
	var property image="tiempo.png"
	var property position=game.at(0,12)
	
}
object puntaje{
	var property image="puntaje.png"
	var property position=game.at(0,0)
	
	
}
