% export data like this from numerical:
% G = struct;
% G.x = getdata("profile", "x");
% G.y = getdata("profile", "y");
% G.z = getdata("profile", "z");
% G.E = getelectric("profile");
% matlabsave("export.mat", G)

classdef fdtd
   properties
       Ex
       Ey
       Ez
       x
       y
       z
   end
   methods
       function obj=fdtd(data) 
           obj.x = data.x .* 1e9;
           obj.y = data.y .* 1e9;
           obj.z = data.z .* 1e9;
           obj.Ex = data.E.Ex;
           obj.Ey = data.E.Ey;
           obj.Ez = data.E.Ez;
       end

       function ret=slice(obj, index)
           sliceX = obj.Ex(:,:,index);
           sliceY = obj.Ey(:,:,index);
           data = sliceX .* conj(sliceX) + sliceY .* conj(sliceY);
%            data = data .^ 4;
           ret=slice(data, obj.x, obj.y);
       end
       
       function cut(obj, index)
           sliceX = squeeze(obj.Ex(index,:,:));
           sliceY = squeeze(obj.Ey(index,:,:));
           data = sliceX .* conj(sliceX) + sliceY .* conj(sliceY);
           h= pcolor(data);
           colormap('hot');
           set(h,'LineStyle','none'); 
           colorbar;
           caxis([0 400]);
       end
       
       function draw_slices(obj, count)
           for i=1:count
              index = int32(length(obj.z) / count * i);
              obj.slice(index).draw;
              ch=findall(gcf,'tag','Colorbar');
              delete(ch);
              axis off;
              saveas(gcf,['slices/chart' sprintf('%02d',i) '.png']);
           end
       end

       function slice=at(obj, z)
            [~, index] = min(abs(obj.z - z));
            slice = obj.slice(index);
       end

       function ret=image(obj, map)
           x_length = length(obj.x);
           y_length = length(obj.y);
           grid_size= 0.5;
           data = ones(x_length, y_length);
           for x_loop=1:x_length
               for y_loop=1:y_length
                   height = map.height(x_loop, y_loop);
                   [~, index] = min(abs(obj.z - height));
                   sliceX = obj.Ex(x_loop,y_loop,index);
                   sliceY = obj.Ey(x_loop,y_loop,index);
                   sliceZ = obj.Ey(x_loop,y_loop,index);
                   height_next_x = map.height(x_loop+1, y_loop);
                   height_next_y = map.height(x_loop+1, y_loop);
                   x_projection = cos(atan((height_next_x - height) / grid_size));
                   y_projection = cos(atan((height_next_y - height) / grid_size));
                   z_projection = 1 - cos(atan((height_next_y - height) / grid_size));
                   data(x_loop, y_loop) = sliceX .* conj(sliceX) * x_projection + sliceY .* conj(sliceY) * y_projection + sliceZ .* conj(sliceZ) * z_projection;
               end
           end
           ret = slice(data, obj.x, obj.y);
       end
   end
end
