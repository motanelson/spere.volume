// MINI TELESCÓPIO
// Configurações principais

comprimento_total = 140;    // Comprimento total do telescópio
diametro_interno = 20;      // Diâmetro interno do tubo
espessura_parede = 3;       // Espessura da parede do tubo
distancia_anilhas = 10;     // Distância das anilhas às extremidades
espessura_anilha = 2;       // Espessura das anilhas de suporte

// ========== CÁLCULOS DERIVADOS ==========
diametro_externo = diametro_interno + 2 * espessura_parede;
raio_interno = diametro_interno / 2;
raio_externo = diametro_externo / 2;

// ========== MÓDULOS PRINCIPAIS ==========

// Tubo principal do telescópio
module tubo_principal() {
    color("Yellow")
    difference() {
        // Tubo externo
        cylinder(h = comprimento_total, r = raio_externo, $fn = 60);
        
        // Vão interno
        translate([0, 0, -1])
        cylinder(h = comprimento_total + 2, r = raio_interno, $fn = 60);
    }
}

// Anilhas de suporte para lentes
module anilha_suporte(posicao_z) {
    color("Yellow")
    translate([0, 0, posicao_z])
    difference() {
        // Disco da anilha
        cylinder(h = espessura_anilha, r = raio_interno, $fn = 60);
        
        // Abertura central (95% do diâmetro interno)
        translate([0, 0, -1])
        cylinder(h = espessura_anilha + 2, r = raio_interno * 0.95, $fn = 60);
    }
}

// Sistema de anilhas completo
module sistema_anilhas() {
    color("Yellow")
    // Anilha frontal (próxima à objetiva)
    anilha_suporte(distancia_anilhas);
    
    // Anilha traseira (próxima à ocular)
    anilha_suporte(comprimento_total - distancia_anilhas - espessura_anilha);
}

// Detalhes decorativos (opcionais)
module detalhes_decorativos() {
     color("Yellow")
    // Anéis decorativos ao longo do tubo
    for(z = [30:30:comprimento_total-30]) {
        translate([0, 0, z])
        difference() {
            cylinder(h = 2, r = raio_externo, $fn = 60);
            cylinder(h = 2.1, r = raio_externo - 1, $fn = 60);
        }
    }
    
    // Texto "Telescope" gravado
    color("Yellow")
    translate([0, -raio_externo - 2, comprimento_total/2])
    rotate([90, 0, 0])
    linear_extrude(height = 1)
    text("TELESCOPE", size = 5, halign = "center", valign = "center", $fn = 20);
}

// ========== MONTAGEM FINAL ==========
union() {
    tubo_principal();
    sistema_anilhas();
    detalhes_decorativos();
}

// ========== VISUALIZAÇÃO DAS LENTES ==========
// Lente objetiva (frontal)
color("Yellow")
%translate([0, 0, distancia_anilhas - 1])
color("Yellow", 0.5)
cylinder(h = 1, r = raio_interno * 0.95, $fn = 60);

// Lente ocular (traseira)
%translate([0, 0, comprimento_total - distancia_anilhas - espessura_anilha + 1])
color("Yellow", 0.5)
cylinder(h = 1, r = raio_interno * 0.95, $fn = 60);

// ========== INFORMAÇÕES TÉCNICAS ==========
echo("=== ESPECIFICAÇÕES DO TELESCÓPIO ===");
echo(str("Comprimento total: ", comprimento_total, "mm"));
echo(str("Diâmetro interno: ", diametro_interno, "mm"));
echo(str("Diâmetro externo: ", diametro_externo, "mm"));
echo(str("Espessura da parede: ", espessura_parede, "mm"));
echo(str("Posição das anilhas: ", distancia_anilhas, "mm das extremidades"));

/*
INSTRUÇÕES DE USO E MONTAGEM:

1. IMPRESSÃO:
   - Imprima na vertical (em pé) para melhor qualidade
   - Use preenchimento de 20-25%
   - Velocidade moderada para detalhes precisos

2. MONTAGEM:
   - As lentes (não incluídas) devem ser encaixadas nas anilhas
   - Use cola para fixar as lentes nas anilhas
   - A anilha frontal suporta a lente objetiva
   - A anilha traseira suporta a lente ocular

3. PERSONALIZAÇÃO:
   - Ajuste 'diametro_interno' para suas lentes específicas
   - Modifique 'distancia_anilhas' conforme necessário
   - Altere 'espessura_anilha' para maior/menor suporte

DICAS:
- Para lentes de 25mm de diâmetro, aumente 'diametro_interno' para 25
- Para telescópio mais robusto, aumente 'espessura_parede' para 4-5mm
- Para melhor estética, pinte após a impressão
*/