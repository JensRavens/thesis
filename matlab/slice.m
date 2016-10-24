classdef slice
   properties
       E
       x
       y
   end
   methods
       function obj=slice(E, x, y)
           obj.E = E;
           obj.x = x;
           obj.y = y;
       end
       
       function draw(obj)
           colormap('hot');
           xaxis=cat(1,obj.x,abs(flipud(obj.x)));
           yaxis=flipud(cat(1,obj.y,abs(flipud(obj.y))));
           h = pcolor(xaxis, yaxis, obj.mirror);
           set(h,'LineStyle','none'); 
           caxis([0 120])
           cbh=colorbar('v');
           set(cbh,'YTick', linspace(0,100,3))
           axis([-80 80 -160 160]);
           view(90, -90);
           daspect([1 1 1]);
           set(gca,'FontSize', 18);
           xlabel('y(nm)');
           ylabel('x(nm)');
           set(gca,'Xtick', linspace(-100,100,5));
           set(gca,'Ytick', linspace(-150,150,7));
       end
       
       function plot_y(obj)
          data = obj.mirror;
          data = data(:, length(obj.y));
          xaxis=cat(1,obj.x,abs(flipud(obj.x)));
          plot(xaxis, data);
          set(gca,'Ytick', linspace(0,100,3));
          set(gca,'Xtick', linspace(-200,200,5));
          axis([-200 200 -10 100]);
          xlabel('x(nm)');
          ylabel('|E/E_0|^2');
          daspect([1.7 1 1]);
          set(gca,'FontSize', 18);
       end
       
       function data=mirror(obj)
           data = [obj.E fliplr(obj.E)];
           data = [data; flipud(data)];
       end
       
       function value=average(obj)
           value = mean(reshape(obj.E.^2, 1, []));
       end
       
       function val=values(obj)
           val = reshape(obj.E, 1, [])';
       end
       
       function val=min(obj)
           val = min(obj.values);
       end
       
       function val=max(obj)
           val = max(obj.values);
       end
       
       function val=x_span(obj)
           val = abs(min(obj.x) - max(obj.x));
       end
       
       function val=y_span(obj)
           val = abs(min(obj.y) - max(obj.y));
       end
       
       function val=base_value(obj)
           val = mean(obj.E(1, :))^2;
       end
       
       function val=extrapolate(obj, radius)
           base_area = radius * radius * 0.25 * pi;
           area = obj.x_span * obj.y_span;
           missing_area = base_area - area;
           base_value = obj.base_value;
           average = obj.average;
           val = (area * average + missing_area * base_value) / base_area;
       end
       
       function data=blur(obj, radius)
           x_length = length(obj.x);
           y_length = length(obj.y);
           data = ones(x_length, y_length);
           for x_loop=1:x_length
               for y_loop=1:y_length
                   x_start = max([1 x_loop-radius]);
                   x_end = min([x_loop+radius x_length]);
                   y_start = max([1 y_loop-radius]);
                   y_end = min([y_loop+radius y_length]);
                   submatrix = obj.E(x_start:x_end, y_start:y_end);
                   data(x_loop, y_loop) = mean(reshape(submatrix, 1, []));
               end
           end
           data = slice(data, obj.x, obj.y);
       end
   end
end