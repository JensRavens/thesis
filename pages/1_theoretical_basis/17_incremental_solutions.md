#### Incremental Numerical Solutions of Maxwell's Equations

_The following calculations are done in one dimension only for simplicity but can be easily expanded to more dimensions (see [Numerical Electromagnetics][NumEl] for detailed calculations in multiple dimensions)._

Given a function $f$ we can calculate its value at a point $x_0\pm\frac{\delta}{2}$ as a Tailor expansion at $x_0$:

$$f\left(x_0+\frac{\delta}{2}\right)=f(x_0)+\frac{\delta}{2}f'(x_0)+\frac{1}{2!}\left(\frac{\delta}{2}\right)^2f''(x_0)+\frac{1}{3!}\left(\frac{\delta}{2}\right)^3f'''(x_0)+\dots$$
$$f\left(x_0-\frac{\delta}{2}\right)=f(x_0)-\frac{\delta}{2}f'(x_0)+\frac{1}{2!}\left(\frac{\delta}{2}\right)^2f''(x_0)-\frac{1}{3!}\left(\frac{\delta}{2}\right)^3f'''(x_0)+\dots$$

Substracting these equations leads to

$$f\left(x_0+\frac{\delta}{2}\right)-f\left(x_0-\frac{\delta}{2}\right)=\delta f'(x_0)+\frac{2}{3!}\left(\frac{\delta}{2}\right)^3f'''(x_0)+\dots$$

Dividing by $\delta$ and rearranging gives

$$\left.\frac{df(x)}{dx}\right|_{x=x_0} = \frac{f(x_0+\frac{\delta}{2})-f(x_0-\frac{\delta}{2})}{\delta} + O(\delta^2)$$

where $O(\delta^2)$ stands for higher order $\delta$ terms.

Assuming the electric field only has a $z$-Component, Maxwell's equations give:

$$-\mu\frac{\partial\mathbf{H}}{\partial t}=\nabla\times\mathbf{E} \Rightarrow \mu\frac{\partial H_y}{\partial t} = \frac{\partial E_z}{\partial x}$$
$$\epsilon\frac{\partial\mathbf{E}}{\partial t}=\nabla\times\mathbf{H} \Rightarrow \epsilon\frac{\partial E_z}{\partial t} = \frac{\partial H_y}{\partial x}$$

According to [Yee][] this is discretized with $t=q\Delta\_t$ and $x=m\Delta_x$.

Taking the first equation with and using the times $q+\frac{1}{2}$ and $q-\frac{1}{2}$ and the locations $m+1$ and $m$ this gives:

$$\epsilon\frac{H_y((q+\frac{1}{2})\Delta_t, (m+\frac{1}{2})\Delta_x)-H_y((q-\frac{1}{2})\Delta_t, (m+\frac{1}{2})\Delta_x)}{\Delta_t}=\frac{E_z(q\Delta_t, (m+1)\Delta_x)-E_z(q\Delta_t, m\Delta_x)}{\Delta_t}$$

[NumEl]: ... (Numerical Electromagnetics, Umran S. Inan (2011))
[Yee]: http://adsabs.harvard.edu/abs/1966ITAP...14..302Y (Numerical solution of inital boundary value problems involving maxwell's equations in isotropic media)
