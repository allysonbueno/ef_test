# validações realizadas no google colab, utilizando lib pandas
pip install pandas
import pandas as pd

dfboard = pd.read_excel('/content/Board_game_principal.xlsx')
dfcateg = pd.read_excel('/content/Category_designer.xlsx')
dfrate =  pd.read_excel('/content/Rating.xlsx')

joinRate = pd.merge(dfboard, dfrate, how='left', on='game_id')
joinCategory = pd.merge(dfboard, dfcateg, how='left', on='game_id')
fullJoin = pd.merge(joinCategory, dfrate, how='left', on='game_id')

# 1) Qual designer de jogos possuí a maior media de avaliação dentre 
# todos os seus jogos publicados? Atente-se à qual tipo de media é a mais adequada aos dados fornecidos
fullJoin.groupby('designer')['avg_rating'].max().reset_index().sort_values(['avg_rating'], ascending=False).head(1)

# 2) Quais os 5 jogos com durabilidade de até 120 min pior avaliados?
Less120 = fullJoin['max_time']<=120
Less120Worst5 = fullJoin.sort_values(by='avg_rating', ascending=True).loc[Less120].head(5)
Less120Worst5[['game_id', 'names']]


# 3) Um cliente pretende comprar os 5 jogos melhores avaliados que atendam as seguintes características: Seja da categoria ficção científica (“Science Fiction”), 
# o máximo de jogadores seja 6 e possua a  mecânica de controle de área (“Area control”) . Quais jogos o cliente deve por no carrinho? 
filtro01 = fullJoin.category.str.contains('Science Fiction')
filtro02 = fullJoin.max_players <= 6
filtro03 = fullJoin.mechanic.str.contains('Area Control')
filtroGeral = filtro01 & filtro02 & filtro03 
carrinho = fullJoin.sort_values(by='avg_rating', ascending=False).loc[filtroGeral].head(5)
carrinho[['game_id', 'names']]