-- BANCO E TABELAS CRIADAS NO SQL NOS MESMO PADRÕES DOS ARQUIVOS XLS

-- 1) Qual designer de jogos possuí a maior media de avaliação dentre todos os seus jogos publicados? 
-- Atente-se à qual tipo de media é a mais adequada aos dados fornecidos
SELECT CD.DESIGNER, RT.AVG_RATING, CD.GAME_ID
FROM RATING RT
INNER JOIN CATEGORY_DESIGNER CD ON CD.GAME_ID = RT.GAME_ID
WHERE RT.AVG_RATING IN (SELECT MAX(AVG_RATING) FROM RATING) 

-- 2) Quais os 5 jogos com durabilidade de até 120 min pior avaliados?
SELECT TOP 5 BG.GAME_ID, 
	BG.MAX_TIME,
	RT.AVG_RATING
FROM BOARD_GAME_PRINCIPAL BG
INNER JOIN CATEGORY_DESIGNER CD ON CD.GAME_ID = BG.GAME_ID
INNER JOIN RATING RT ON RT.GAME_ID = BG.GAME_ID
WHERE BG.MAX_TIME <= 120
ORDER BY RT.AVG_RATING ASC


-- 3) Um cliente pretende comprar os 5 jogos melhores avaliados que atendam as seguintes características: 
-- Seja da categoria ficção científica (“Science Fiction”), 
-- o máximo de jogadores seja 6 e possua a 
-- mecânica de controle de área (“Area control”) . Quais jogos o cliente deve por no carrinho? 
SELECT TOP 5	
	BG.GAME_ID,
	BG.NAMES
FROM BOARD_GAME_PRINCIPAL BG
INNER JOIN CATEGORY_DESIGNER CD ON CD.GAME_ID = BG.GAME_ID
INNER JOIN RATING RT ON RT.GAME_ID = BG.GAME_ID
WHERE UPPER(CD.CATEGORY) LIKE '%SCIENCE FICTION%'
	AND BG.MAX_PLAYERS <= 6
	AND UPPER(BG.MECHANIC) LIKE '%AREA CONTROL%'
ORDER BY RT.AVG_RATING DESC