 Calculadora Avanzada en Flutter

Esta aplicación permite realizar operaciones matemáticas avanzadas a partir de dos números ingresados por el usuario. Utiliza TextEditingController para manejar la entrada de datos y valida que las entradas sean correctas antes de calcular los resultados.

 Tecnologías utilizadas

Flutter (SDK para apps multiplataforma)

Dart (lenguaje de programación)

Estructura del Código
1. main() y MyApp
void main() {
  runApp(const MyApp());
}


Es el punto de entrada de la aplicación.

Llama al widget MyApp, que define el tema y la pantalla inicial.

2. Pantalla de Inicio (HomeScreen)
class HomeScreen extends StatelessWidget {
  ...
}


Muestra el título de la app, un ícono y un botón “Comenzar”.

Al presionar el botón, se navega hacia la pantalla de la calculadora con Navigator.push.

3. Pantalla de la Calculadora (CalculatorScreen)
class CalculatorScreen extends StatefulWidget {
  ...
}


Aquí está toda la lógica de la calculadora.

Tiene dos TextEditingController (_num1Controller y _num2Controller) para capturar los valores ingresados.

Los TextField están configurados con FilteringTextInputFormatter para permitir solo números (enteros o decimales).

4. Función _calcular(String tipo)
void _calcular(String tipo) {
  ...
}


Ejecuta la operación dependiendo del botón presionado (suma, resta, multiplicacion, etc.).

Valida que los campos no estén vacíos y que los valores sean válidos.

Implementa las operaciones:

Suma → n1 + n2

Resta → n1 - n2

Multiplicación → n1 * n2

División → calcula cociente y residuo (~/ y %)

Potencia → pow(n1, n2)

Radicación → pow(n1, 1/n2)

Logaritmo → log(n1) / log(n2)

 Incluye validaciones importantes:

División por cero → Error.

Logaritmo válido → número y base positivos, base distinta de 1.

5. Función _limpiar()
void _limpiar() {
  _num1Controller.clear();
  _num2Controller.clear();
  _resultado = "";
  _operacion = "";
}


Limpia los campos de entrada y el resultado.

6. Interfaz de Usuario

Dos campos de texto para ingresar los números.

Botones para cada operación en un Wrap (organiza botones en filas automáticas).

Área de resultados que muestra:

Operación realizada.

Resultado principal (y resultados adicionales, como cociente y residuo).

Botón de limpiar para reiniciar la calculadora.

 Validaciones Implementadas

Los campos no pueden estar vacíos.

Solo se permiten números (enteros y decimales).

División por cero muestra un error.

Logaritmos requieren números positivos y base diferente de 1.

Ejemplo de Uso

Ingresar dos números en los campos.

Seleccionar una operación (ejemplo: Potencia).

Ver el resultado en la sección de resultados.

Si la operación no es válida, se muestra un mensaje de error.
