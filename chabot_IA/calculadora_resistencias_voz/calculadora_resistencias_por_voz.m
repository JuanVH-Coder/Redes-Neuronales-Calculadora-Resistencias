function calculadora_resistencias_por_voz()
    % Definir los colores de las bandas
    colores = {'Negro', 'Marron', 'Rojo', 'Naranja', 'Amarillo', 'Verde', 'Azul', 'Violeta', 'Gris', 'Blanco', 'Dorado', 'Plateado'};
    
    % Solicitar los colores mediante voz
    disp('Por favor, diga el color de la primera banda:');
    banda1 = reconocer_color(colores);
    
    disp('Por favor, diga el color de la segunda banda:');
    banda2 = reconocer_color(colores);
    
    disp('Por favor, diga el color de la tercera banda:');
    banda3 = reconocer_color(colores);
    
    % Definir el valor del cuarto color siempre como Dorado
    banda4 = 'Dorado';
    
    % Calcular el valor de la resistencia
    valor_resistencia = calcular_valor_resistencia(banda1, banda2, banda3, colores);
    
    % Mostrar el resultado
    fprintf('El valor de la resistencia es: %.2f ohms\n', valor_resistencia);
    
    % Mostrar la imagen según el valor de la resistencia
    mostrar_imagen(valor_resistencia);
end

function color = reconocer_color(colores)
    % Función para obtener la entrada del usuario
    input_valido = false;
    while ~input_valido
        % Utilizar la función input para obtener la entrada
        respuesta = lower(input('Ingrese el color: ', 's'));
        
        % Buscar el color en la lista
        color = encontrar_color(respuesta, colores);
        
        % Validar la entrada
        if isempty(color)
            disp('Color no reconocido. Por favor, intente nuevamente.');
        else
            input_valido = true;
        end
    end
end

function color = encontrar_color(respuesta, colores)
    % Función para buscar el color en la respuesta
    color = '';
    for i = 1:length(colores)
        if contains(respuesta, lower(colores{i}))
            color = colores{i};
            break;
        end
    end
end

function valor_resistencia = calcular_valor_resistencia(banda1, banda2, banda3, colores)
    % Definir los valores para cada color en la banda
    valores = [0 1 2 3 4 5 6 7 8 9];
    
    % Definir los multiplicadores para cada color en la banda
    multiplicadores = [1 10 100 1000 10000 100000 1000000 10000000 100000000 1000000000];
    
    % Obtener los valores para cada color
    valor1 = valores(strcmp(banda1, colores));
    valor2 = valores(strcmp(banda2, colores));
    multiplicador = multiplicadores(strcmp(banda3, colores));
    
    % Calcular el valor de la resistencia
    valor_resistencia = (valor1 * 10 + valor2) * multiplicador;
end

function mostrar_imagen(valor_resistencia)
    % Definir los valores específicos para los cuales mostrar imágenes
    valores_imagenes = [1 1.2 1.5 1.8 2.2 2.7 3.3 3.9 4.7 5.1 5.6 6.8 8.2 ...
                        10 12 15 18 22 27 33 39 47 51 56 68 82 ...
                        100 120 150 180 220 270 330 390 470 510 560 680 820 ...
                        1000 1200 1500 1800 2200 2700 3300 3900 4700 5100 5600 6800 8200 ...
                        10000 12000 15000 18000 22000 27000 33000 39000 47000 51000 56000 68000 82000 ...
                        100000 120000 150000 180000 220000 270000 330000 390000 470000 510000 560000 680000 820000 ...
                        1000000 1200000 1500000 1800000 2200000];
         % Definir la carpeta de imágenes con la ruta completa
    carpeta_imagenes = 'D:\Descargas\chabot_IA\calculadora_resistencias_voz\imagenes';
    
    % Formatear el número de resistencia como cadena sin espacios
    num_resistencia_str = strrep(num2str(valor_resistencia), '.', '_');
    
    % Construir el nombre completo del archivo de imagen
    nombre_archivo = fullfile(carpeta_imagenes, ['imagen_resistencia_', num_resistencia_str, '.png']);
    
    % Verificar si el archivo de imagen existe antes de intentar cargarlo
    if exist(nombre_archivo, 'file') == 2
        % Mostrar la imagen
        imshow(nombre_archivo);
        title(['Resistencia: ', num2str(valor_resistencia), ' ohms']);
    else
        disp(['No hay imagen disponible para la resistencia: ', num2str(valor_resistencia), ' ohms.']);
    end
end

