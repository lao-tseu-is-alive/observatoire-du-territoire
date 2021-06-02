## Indicateurs de végétation avec données RGB
Comme première approche, il serait pertinent de tester avec les ortophotos RGB pour profiter de leur disponibilité régulière sur l'échelle temporelle et spatiale. Même si les ortophotos avec NIR sont plus pertinentes pour ce genre d'analyse, nous en avons malheureusement pas à disposition de manière régulière ce qui ne permet pas d'avoir une vision d'ensemble sur l'évolution temporelle de la végétation.  

Les indicateurs présentés ci-dessous ont été appliqués dans la publication [Vegetation Extraction Using Visible-Bands From Openly Licensed Unmanned Aerial Vehicle Imagery](https://www.sciencedirect.com/science/article/abs/pii/S0034425701002899) qui les applique sur différentes zones géographiques afin de voir quel indicateur est le plus pertinent. Dans cette étude, le [Green Leaf Index (GLI)](#green-leaf-index) a fournit les meilleurs résultats pour tout cas d'étude.

De même, le [Triangular Greenness Index (TGI)](#triangular-greenness-index) s'est révélé efficace dans l'étude [A visible band index for remote sensing leaf chlorophyll content at the canopy scale](https://digitalcommons.unl.edu/cgi/viewcontent.cgi?referer=&httpsredir=1&article=2161&context=usdaarsfacpub).

L'approche la plus pertinente serait de tester chacun de ces indicateurs et ensuite tester visuellement ou avec des points tests dont on connaît l'affectation du sol, pour ensuite estimer l'indicateur le plus adapté pour les ortophotos que l'on a disposition.

### Visible atmospherically resistant index

Estime quantitativement la fraction de la végétation uniquement à partir de la plage visible du spectre et est peu sensible aux effets atmosphériques

`VARI = (Green - Red)/ (Green + Red - Blue)`

### Red–green–blue vegetation index

Indicateur normalisé qui permet d'amplifier la différence entre les différentes bandes (bandes au carré).

`RGBVI = ((Green*Green) – (Red*Blue)) / ((Green*Green) + (Red*Blue))`

### Normalized green red difference index


`NGRDI = (Green − Red) / (Green + Red)`

### Green Leaf Index  
Le plus efficace selon l'étude [Vegetation Extraction Using Visible-Bands From Openly Licensed Unmanned Aerial Vehicle Imagery](https://www.sciencedirect.com/science/article/abs/pii/S0034425701002899)

`GLI = (2*Green - Red - Blue) / (2*Green + Red + Blue)`

### Triangular greenness index

Efficace à l'échelle de la canopée [https://digitalcommons.unl.edu/cgi/viewcontent.cgi?referer=&httpsredir=1&article=2161&context=usdaarsfacpub](https://digitalcommons.unl.edu/cgi/viewcontent.cgi?referer=&httpsredir=1&article=2161&context=usdaarsfacpub)

`TGI = 0.5*[(λr– λb)(Red − Green) − (λr − λg)(Red − Green)]`

λx = wavelength of band  
### Red–green Ratio index

En faisant le ratio, on enlève les erreurs atmosphériques

`RGRI = Red/Green`

### Modified green–red vegetation index

Indice normalisé similaire à [Normalized green red difference index](#normalized-green-red-difference-index). Le carré accentue les différences ?


MGRVI = (Green<sup>2</sup> – Red<sup>2</sup>) / (Green<sup>2</sup>+ Red<sup>2</sup>)



## Bibliography
[1] [Novel algorithms for remote estimation of vegetation fraction, Gitelson et al. , 2002.](https://www.sciencedirect.com/science/article/abs/pii/S0034425701002899)

[2] [Vegetation Extraction Using Visible-Bands From Openly Licensed Unmanned Aerial Vehicle Imagery, A. Agapiou, 2020 ](https://www.researchgate.net/publication/342526228_Vegetation_Extraction_Using_Visible-Bands_From_Openly_Licensed_Unmanned_Aerial_Vehicle_Imagery)

[3] [Evaluation of RGB-based vegetation indices from UAV imagery to estimate forage yield in grassland, U. Lussem et al., 2018](https://d-nb.info/1161192468/34)

[4] [A visible band index for remote sensing leaf chlorophyll content at the canopy scale the canopy scale, Hunt Jr, E. Raymond, et al., 2013](https://digitalcommons.unl.edu/cgi/viewcontent.cgi?referer=&httpsredir=1&article=2161&context=usdaarsfacpub)
