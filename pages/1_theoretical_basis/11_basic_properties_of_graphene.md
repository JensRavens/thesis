### Basic Properties of Graphene

Graphene is an example of a two dimensional hexagon atom structure (also called honeycomb structure). Although it only has been discovered and researched recently in [2004][props] graphene has sparked increasing interest with scientists due to its extraordinary mechanical, optical and electric properties.

#### Graphene Grid

![https://en.wikipedia.org/wiki/File:Graphene_SPM.jpg](../images/graphene-spm.png)
_Graphene's two dimensional hexagonal structure as seen through scanning probe microscopy (adapted from [1])._

Graphene is a two dimensional allotrope of carbon where atoms are densely packed in a hexagonal pattern with a distance of about 1.42Å. Each sp²-hybridized carbon atom has a covalent $\sigma$-bond to three other carbon atoms.

>![](../images/cell.png)
>_The basis vectors $\mathbf{a}_1$ and $\mathbf{a}_2$ build a triangular Bravais lattice with a two atom-basis. The Wigner-Seitz cell is shaded in gray (adapted from [2])._
>
>![](../images/k-cell.png)
>_The reciprocal lattice points to the hexagonal grid of the two atom base grid. The unit cell is shaded in gray, $\Gamma$ is the cell's center; $K\_+$, $K\_-$ and $M$ are highly symmetric points (adapted from [2])._

![http://www.andrew.cmu.edu/user/feenstra/graphene/](../images/orbitals.jpg)
_Valence orbitals of carbon atoms in graphene. Covalent bonded atoms are formed from $\sigma$-orbitals while the perpendicular $\pi$-orbitals create the valence and conduction band. Adapted from [orbitals]._

The $\pi$ orbitals hybridize and form a continuous cloud of electrons above and below the graphene lattice enabling ballistic transport of electrons and its high carrier mobility.

#### Band Structure and Band Gap

Due to the symmetry of the system the $\pi$ orbitals can be treated independently and as the main contributor to the conduction and valence band. The [dispersion relation is][bands]

$$E(\mathbf{k})=\pm\sqrt{\gamma_0^2\left(1+4\cos^2\frac{k_ya}{2}+4\cos\frac{k_ya}{2}\cdot\cos\frac{k_x\sqrt{3}a}{2}\right)},$$

with the hopping energy $\gamma_0\approx2.8eV$, the lattice constant $a\approx2.46Å$, "$+$" for the conduction band and "$-$" for the valence band.

>![](../images/band-2d.png)
>_Conduction and valence band touch in the points $K\_-$ and $K\_+$._
>
>![http://exciting-code.org/boron10-graphene-from-the-ground-state-to-excitations](http://exciting.wdfiles.com/local--files/boron10-graphene-from-the-ground-state-to-excitations/graphene-2.png)
>_At the K points the conduction and valance bands can be linearly approximated._

Evaluating these equation at the K points gives

$$E(\mathbf{K})=0,$$

confirming that conduction and valence band touch in the K points and therefore graphene is a semiconductor without a band gap.

#### Other Properties

Other interesting properties of graphene often exceed those of any other material. It has an intrinsic [tensile strength of 130 GPa and a Young's modulus as high as 1TPa][mechanical]. Also it's [impermeable to gases][impermeable] and has a light absorption of exactly [$\pi\alpha$][absorption].

[props]: Graphene
[grid]: http://www.hindawi.com/journals/isrn/2012/501686/
[orbitals]: http://www.andrew.cmu.edu/user/feenstra/graphene/
[bands]: http://adsabs.harvard.edu/abs/1947PhRv...71..622W
[mechanical]: http://adsabs.harvard.edu/abs/2008Sci...321..385L
[impermeable]: impermeable atomic membranes from graphene sheets
[absorption]: Fine structure constant defines visual transperencz of graphene
