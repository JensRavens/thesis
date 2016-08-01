#### Incremental Numerical Solutions of Maxwell's Equations

_The following calculations are done in one dimension only for simplicity but can be easily expanded to more dimensions (see [Numerical Electromagnetics][NumEl] for detailed calculations in multiple dimensions)._

Given a function $f$ we can calculate its value at a point $x_0\pm\frac{\delta}{2}$ as a Tailor expansion at $x_0$ with

$$f\left(x_0+\frac{\delta}{2}\right)=f(x_0)+\frac{\delta}{2}f'(x_0)+\frac{1}{2!}\left(\frac{\delta}{2}\right)^2f''(x_0)+\frac{1}{3!}\left(\frac{\delta}{2}\right)^3f'''(x_0)+\dots,$$

$$f\left(x_0-\frac{\delta}{2}\right)=f(x_0)-\frac{\delta}{2}f'(x_0)+\frac{1}{2!}\left(\frac{\delta}{2}\right)^2f''(x_0)-\frac{1}{3!}\left(\frac{\delta}{2}\right)^3f'''(x_0)+\dots.$$

Substracting these equations leads to

$$f\left(x_0+\frac{\delta}{2}\right)-f\left(x_0-\frac{\delta}{2}\right)=\delta f'(x_0)+\frac{2}{3!}\left(\frac{\delta}{2}\right)^3f'''(x_0)+\dots.$$

Dividing by $\delta$ and rearranging gives

$$\left.\frac{df(x)}{dx}\right|_{x=x_0} = \frac{f(x_0+\frac{\delta}{2})-f(x_0-\frac{\delta}{2})}{\delta} + O(\delta^2),$$

where $O(\delta^2)$ stands for higher order $\delta$ terms which can be neglected for small $\delta$.

Assuming the electric field only has a $z$-Component, Maxwell's equations give

$$-\mu\frac{\partial\mathbf{H}}{\partial t}=\nabla\times\mathbf{E} \Rightarrow \mu\frac{\partial H_y}{\partial t} = \frac{\partial E_z}{\partial x},$$

$$\epsilon\frac{\partial\mathbf{E}}{\partial t}=\nabla\times\mathbf{H} \Rightarrow \epsilon\frac{\partial E_z}{\partial t} = \frac{\partial H_y}{\partial x}.$$

[NumEl]: ... (Numerical Electromagnetics, Umran S. Inan (2011))
