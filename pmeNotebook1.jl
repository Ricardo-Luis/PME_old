### A Pluto.jl notebook ###
# v0.14.1

using Markdown
using InteractiveUtils

# ╔═╡ fa4e46d8-b3b0-451c-9a25-a36dfc5b1dfe
begin
	#import Pkg
	#Pkg.activate(mktempdir())
	#using Pkg
	#Pkg.add(["Plots", "PlutoUI", "PyCall"])	# instalação de packages
	using PyCall   # chamar linguagem Python
	using PlutoUI # user-interface do Pluto.jl
	using Plots  # Julia package para gráficos 
end

# ╔═╡ 4614a560-9b71-11eb-091e-4f3ed9bc35e3
md"""
# *Notebook*: pmeNotebook1.jl [![forthebadge](https://forthebadge.com/images/badges/made-with-julia.svg)](https://julialang.org/)  
##### *Packages*: [Plots](http://docs.juliaplots.org/latest/), [PlutoUI](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/), [PyCall](https://github.com/JuliaPy/PyCall.jl)  
##### Copiar o URL do *notebook* em: [![](https://img.shields.io/badge/PME-GitHub-green.svg)](https://github.com/Ricardo-Luis/PME), para o abrir no seu Julia\Pluto
"""

# ╔═╡ 43efcca9-24ee-49eb-9bbc-1448e86af0e4
html"<button onclick='present()'>present</button>"

# ╔═╡ 98fa8d3c-9632-4cd4-81a4-f4aa107faae6
md"""
# *Notebooks* em *Julia\Pluto*
"""

# ╔═╡ 5570fe10-a878-4686-8c70-bf40741fbafc
md"""
**_Pluto_** é uma interface para *notebook* baseada em navegador *web* (recomendado: Mozilla Firefox ou Google Chrome) para a linguagem de programação *Julia*. Ele permite combinar o código *Julia* e os resultados computacionais com texto, expressões matemáticas, imagens, etc., de uma forma interligada e interactiva com o utilizador. 
"""

# ╔═╡ 95173c4c-176d-4790-b236-27de3dfe9cea
md"""
## Porquê *Julia*?  
"""

# ╔═╡ 581f1d64-29ee-4851-9330-fe3d4a98cad7
md"""
- linguagem de computação científica _open-source_ 
- fácil adopção, principalmente para quem conhece MATLAB: ver comparativo entre [MATLAB _vs._ Python _vs._ Julia](https://cheatsheets.quantecon.org/)
- artigo de opinião: [10 Reasons Why You Should Learn Julia](https://blog.goodaudience.com/10-reasons-why-you-should-learn-julia-d786ac29c6ca)
"""

# ╔═╡ 464d6e10-3cca-47b8-aa9b-64e24d1ca14f
md"""
## Porquê *Pluto*?  
"""

# ╔═╡ af9761e5-14fb-4cc0-9627-3b251a78da62
md"""
- permite programação literária e reactiva. [Vídeo de apresentação do Pluto, 24min.](https://youtu.be/IAF8DjrQSSk)
- os _notebooks_ criados no *Pluto* são ficheiros **_Julia_**, ou seja, os mesmos podem ser utilizados em editores de código ou em ambiente de desenvolvimento integrado (IDE) como Visual Studio, Atom...  
- permite fazer ciência reproduzível!! \
![](https://i.imgur.com/shIpaY1.png) \
Fonte: Xing Su, "Reproducible Research Course Notes", Data Science Specialization, Johns Hopkins University, Fev. 2016.

- artigo de opinião: [A Guide to Building Reactive Notebooks for Scientific Computing With Julia and Pluto.jl](https://medium.com/swlh/a-guide-to-building-reactive-notebooks-for-scientific-computing-with-julia-and-pluto-jl-1a2c0c455d51)
"""

# ╔═╡ d750080e-69a3-4d17-a274-a938be51cd70
md"""
### Limitações do *Pluto*
- o facto de executar tudo... e poder haver partes de longa execução que não seriam necessárias. Mas estão a trabalhar nisso:
- **PlutoCon 2021**: [Visualizing cell dependencies and execution barriers](https://youtu.be/UJRRauTR9Qg?t=827), Benjamin Lungwitz 

**Resumo**:
Reactivity for notebooks is great! But in practice, cell dependencies causing re-evaluations are not always obvious (and sometimes even accidential). In addition, there may be long-running cells which should not be updated automatically for each upstream change.  \
In this presentation I show you the current state of cell dependency visualizations and execution barriers in Pluto.

- construir slides para uma apresentação parece ainda ter alguns problemas e exige alguns truques: [Building slides with Pluto.jl](https://andreaskroepelin.de/blog/plutoslides/), Andreas Kröpelin.
"""

# ╔═╡ a2b16233-1a5a-47df-87b8-be8724d7a770
md"""
## Instalação do Julia e Pluto
"""

# ╔═╡ b649e7cf-3153-4929-a64e-2ca64de0eee7
md"""
Versão vídeo e versão escrita de instalação de Julia e Pluto: [First-time setup: Install Julia & Pluto](https://computationalthinking.mit.edu/Spring21/installation/)
"""

# ╔═╡ c86c0119-487c-429d-a7a8-1dc022c794ca
md"""
# FEMM 
"""

# ╔═╡ c255a6d2-e66e-41ef-bd9f-ca1f9e248122
md"""
## Exemplo de modelo com CAD paramétrico 
"""

# ╔═╡ d46b14ee-7185-42e1-b590-59f85ca9619f
md"""
**Objectivo**: desenhar um núcleo de transformador com a geometria da figura, mas de dimensões variáveis (CAD paramétrico). \
![](https://i.imgur.com/kyvAs6W.jpg)
"""

# ╔═╡ 937a7902-4553-46f5-8e25-3a438719a6a4
md"""
### Importação da biblioteca de comandos do FEMM a partir de *Python*
"""

# ╔═╡ 0adbd32d-c418-4272-a92c-976d6ae95de6
@pyimport femm as f

# ╔═╡ 83337f39-ac9a-49df-8028-5c31ac278fd3
md"""
### Definição de problema no FEMM
"""

# ╔═╡ 37cf28fc-618e-4694-a892-d3427a6f6339
md"""
### Parâmetros CAD
"""

# ╔═╡ a63683ea-29e2-4360-bcbd-0d8a8597e88a
begin
	low=44.1 	#outer legs width, mm
	lcw=42.5 	#center legs width, mm
	hc=111.6 	#half core height, mm
	tc=43.6 	#top/botton core height, mm
	ww=44.5 	#core window width, mm
	cl=2low+lcw+2ww 	#core lenght, mm
	wh=hc-tc 	#half core window height, mm
	cd=44.1 	#core deph, mm
end;

# ╔═╡ 10181196-8cfe-45ac-a1bb-bd58a6ca9b33
begin
	f.openfemm()
	f.newdocument(0)
	f.mi_setgrid(5,"cart")
    f.mi_probdef(0,"millimeters","planar",1.E-8,cd,30,0)
end

# ╔═╡ d30e9a75-d225-4a04-96a7-56b7f7802193
md"""
### Desenho do núcleo
"""

# ╔═╡ 4b90e489-0a38-4f6d-9c46-34f00595e125
begin
	#half core drawing
	f.mi_addnode(0,0)
	f.mi_addnode(low,0)
	f.mi_addnode(low,wh)
	f.mi_addnode(0,wh) #4
	f.mi_addnode(low,hc)
	f.mi_addnode(low+ww,wh)
	f.mi_addnode(low+ww,0)
	f.mi_addnode(low+ww+lcw,0)
	f.mi_addnode(low+ww+lcw,wh) #9
	f.mi_addnode(low+2ww+lcw,wh)
	f.mi_addnode(low+2ww+lcw,0)
	f.mi_addnode(2low+2ww+lcw,0)
	f.mi_addnode(2low+2ww+lcw,wh)
	f.mi_addnode(low+2ww+lcw,hc)
	f.mi_addsegment(0,0,low,0)
	f.mi_addsegment(low,0,low,wh)
	f.mi_addsegment(0,0,0,wh)
	f.mi_addsegment(low,wh,low+ww,wh)
	f.mi_addsegment(low+ww,wh,low+ww,0)  #5
	f.mi_addsegment(low+ww,0,low+ww+lcw,0)
	f.mi_addsegment(low+ww+lcw,0,low+ww+lcw,wh)
	f.mi_addsegment(low+ww+lcw,wh,low+2ww+lcw,wh)
	f.mi_addsegment(low+2ww+lcw,wh,low+2ww+lcw,0)
	f.mi_addsegment(low+2ww+lcw,0,2low+2ww+lcw,0)
	f.mi_addsegment(2low+2ww+lcw,0,2low+2ww+lcw,wh)
	f.mi_addsegment(low,hc,low+2ww+lcw,hc)
	f.mi_addarc(low,hc,0,wh,90,1)
	f.mi_addarc(2low+2ww+lcw,wh,low+2ww+lcw,hc,90,1)
	#2nd half core:
	f.mi_seteditmode("group")
	f.mi_selectgroup(0)
	f.mi_mirror(0,0,2low+2ww+lcw,0)
	f.mi_selectgroup(0)
	f.mi_setgroup(1)
	f.mi_clearselected()
end	

# ╔═╡ 9057bc6b-56fb-4ea2-82b3-2603a06e6dca
md"""
### *zoom ; save as, mesh*
"""

# ╔═╡ 1d8380bd-e958-4352-978e-9f9688d2ab93
begin
	f.mi_zoomnatural()
	f.mi_saveas("1phShell.fem")
	f.mi_createmesh()
end;

# ╔═╡ ae36a7f8-6347-4f11-ad47-6c8e4dbf62b4
md"""
### Adicionar materiais
"""

# ╔═╡ d0451715-efdf-4418-bbdc-194e8106f324
begin
	Cduct=10
	Lam_thck=0.025
	f.mi_addmaterial("Metglas2605SA1.025mm", 1, 1, 0, 0, Cduct, Lam_thck, 0, 0.98, 0, 0, 0, 0, 0);
    f.mi_addbhpoint("Metglas2605SA1.025mm",0.0,0.0)
	f.mi_addbhpoint("Metglas2605SA1.025mm",0.111,0.5)
	f.mi_addbhpoint("Metglas2605SA1.025mm",0.259,0.9)
	f.mi_addbhpoint("Metglas2605SA1.025mm",0.424,1.3)
	f.mi_addbhpoint("Metglas2605SA1.025mm",0.576,1.6)
    f.mi_addbhpoint("Metglas2605SA1.025mm",0.689,1.8)
	f.mi_addbhpoint("Metglas2605SA1.025mm",0.758,1.9)
	f.mi_addbhpoint("Metglas2605SA1.025mm",0.858,2.0)
	f.mi_addbhpoint("Metglas2605SA1.025mm",0.915,2.1)
	f.mi_addbhpoint("Metglas2605SA1.025mm",0.959,2.2)
	f.mi_addbhpoint("Metglas2605SA1.025mm",1.059,2.4)
	f.mi_addbhpoint("Metglas2605SA1.025mm",1.110,2.5)
	f.mi_addbhpoint("Metglas2605SA1.025mm",1.148,2.7)
	f.mi_addbhpoint("Metglas2605SA1.025mm",1.185,3.0)
	f.mi_addbhpoint("Metglas2605SA1.025mm",1.219,3.3)
	f.mi_addbhpoint("Metglas2605SA1.025mm",1.251,3.6)
	f.mi_addbhpoint("Metglas2605SA1.025mm",1.292,4.3)
	f.mi_addbhpoint("Metglas2605SA1.025mm",1.321,5.0)
	f.mi_addbhpoint("Metglas2605SA1.025mm",1.350,5.8)
	f.mi_addbhpoint("Metglas2605SA1.025mm",1.387,7.4)
	f.mi_addbhpoint("Metglas2605SA1.025mm",1.387,7.4)
	f.mi_addbhpoint("Metglas2605SA1.025mm",1.415,10.1)
	f.mi_addbhpoint("Metglas2605SA1.025mm",1.442,22.0)
	f.mi_addbhpoint("Metglas2605SA1.025mm",1.449,33.4)
end

# ╔═╡ 035137fa-e80c-4ad8-8173-220394a5b481
f.mi_saveas("1phShell.fem")

# ╔═╡ bda74f3c-8871-49d7-b79f-359ec8522e1d
md"""
.\
.\
.\
... este projecto há-de continuar!
"""

# ╔═╡ e43c564a-2e9e-4aa4-bbda-0c1f1d7c7171
md"""
# TOC
"""

# ╔═╡ 5b468d3e-4650-42fb-afd6-778130b04fb6
TableOfContents()

# ╔═╡ ccf8217f-3a9c-43e1-bde8-536a14710c13
md"""
# Setup
"""

# ╔═╡ f49ecfdc-ca4a-402f-a3e5-0ea541e8b365
md"""
O *package* **PyCall** serve para chamar instruções de programação *Python*, por conseguinte, é necessário ter previamente [*Python*](https://www.python.org/downloads/) instalado.
"""

# ╔═╡ 32a6ddd0-d7f1-42fe-af59-4cfd17e69a56


# ╔═╡ 4a91269d-e022-4039-9b1f-cc1a310160cb
version=VERSION;

# ╔═╡ 74f1620e-ad77-4a7a-88d1-0a789762853f
md"""
PME2\
*Notebook* realizado em linguagem de programação *Julia* versão: $(version)  \
**Ricardo Luís** (Professor Adjunto) \
ISEL, 12/Abr/2021
"""

# ╔═╡ Cell order:
# ╟─4614a560-9b71-11eb-091e-4f3ed9bc35e3
# ╟─43efcca9-24ee-49eb-9bbc-1448e86af0e4
# ╟─98fa8d3c-9632-4cd4-81a4-f4aa107faae6
# ╟─5570fe10-a878-4686-8c70-bf40741fbafc
# ╟─95173c4c-176d-4790-b236-27de3dfe9cea
# ╟─581f1d64-29ee-4851-9330-fe3d4a98cad7
# ╟─464d6e10-3cca-47b8-aa9b-64e24d1ca14f
# ╟─af9761e5-14fb-4cc0-9627-3b251a78da62
# ╟─d750080e-69a3-4d17-a274-a938be51cd70
# ╟─a2b16233-1a5a-47df-87b8-be8724d7a770
# ╟─b649e7cf-3153-4929-a64e-2ca64de0eee7
# ╟─c86c0119-487c-429d-a7a8-1dc022c794ca
# ╟─c255a6d2-e66e-41ef-bd9f-ca1f9e248122
# ╟─d46b14ee-7185-42e1-b590-59f85ca9619f
# ╟─937a7902-4553-46f5-8e25-3a438719a6a4
# ╠═0adbd32d-c418-4272-a92c-976d6ae95de6
# ╟─83337f39-ac9a-49df-8028-5c31ac278fd3
# ╠═10181196-8cfe-45ac-a1bb-bd58a6ca9b33
# ╟─37cf28fc-618e-4694-a892-d3427a6f6339
# ╠═a63683ea-29e2-4360-bcbd-0d8a8597e88a
# ╟─d30e9a75-d225-4a04-96a7-56b7f7802193
# ╠═4b90e489-0a38-4f6d-9c46-34f00595e125
# ╟─9057bc6b-56fb-4ea2-82b3-2603a06e6dca
# ╠═1d8380bd-e958-4352-978e-9f9688d2ab93
# ╟─ae36a7f8-6347-4f11-ad47-6c8e4dbf62b4
# ╠═d0451715-efdf-4418-bbdc-194e8106f324
# ╠═035137fa-e80c-4ad8-8173-220394a5b481
# ╟─bda74f3c-8871-49d7-b79f-359ec8522e1d
# ╟─e43c564a-2e9e-4aa4-bbda-0c1f1d7c7171
# ╠═5b468d3e-4650-42fb-afd6-778130b04fb6
# ╟─ccf8217f-3a9c-43e1-bde8-536a14710c13
# ╠═fa4e46d8-b3b0-451c-9a25-a36dfc5b1dfe
# ╟─f49ecfdc-ca4a-402f-a3e5-0ea541e8b365
# ╟─32a6ddd0-d7f1-42fe-af59-4cfd17e69a56
# ╟─74f1620e-ad77-4a7a-88d1-0a789762853f
# ╟─4a91269d-e022-4039-9b1f-cc1a310160cb
