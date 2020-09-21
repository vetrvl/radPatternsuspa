function srdemo
%
%SRDEMO Square Radians (STERADIANS) DEMOnstration
%
%       This is a script to help visualize what a Steradian is. The steradian (sr)
%       is used as a unit of measure for FOV (field of view). Setting the range that 
%       a sensor can sense. The sensors are attitude hardware used to determine the
%       attitude for the subsequent control of Spacecraft, Missiles, etc.. Sensors
%       that would use this unit of measure are those that receive Energy Flux
%       through a surface area, such as, Sun, Earth(Horizon), and Star Sensors
%
%       The script is very simple, one needs only to choose the FOV to be visualized
%       in the popup uicontrol box. The script, at this time, needs to be rerun for 
%       each desired steradian value. The value in the popup box is the multiple of ? 
%       steradian quantity. This is for demonstration purposes only so the sphere is
%       is divided into a static finite number of sections. Each section (slit) is 
%       pi/8 sr. This can easily be upgraded so that the user can choose the delta sr.
%       Other modifications that may at some time be necessary or desired are making it a 
%       function, including a reset button so that the script/function does not have to be
%       run each time, and dynamic and/or static text naming the steradian value during
%       the sweep and/or at the end of the run. Also, might try to amimate and calculate
%       the Energy Flux
%       
%       
%
%       The following is an explanation by Warren Davis of Newton, MA. It was found at
%       Physlink.com:
%
%         "Steradians are a measure of the angular 'area' subtended by a two-dimensional 
%         surface about the origin in three dimensional space, just as a radian is a 
%         measure of the angle subtended by a one dimensional line about the origin in 
%         two dimensional (plane) space. Steradians are equivalently referred to as 
%         'square radians.'
% 
%         A sphere subtends 4pi square radians (steradians) about the origin. By analogy,
%         a circle subtends 2pi radians about the origin. Numerically, the number of 
%         steradians in a sphere are equal to the surface area of a sphere of unit radius.
%         I.e., area of sphere = 4pir², but with r = 1, area = 4pi. Likewise,
%         numerically, the number of radians in a circle is equal to the circumference of
%         a circle of unit radius. I.e., circumference = 2pir, but with r = 1, 
%         circumference = 2pi.
% 
%         As one would expect, steradians (square radians) can be converted to square
%         degrees by multiplying by the square of the number of degrees in a 
%         radian = 57.2957795... degrees. For example, the number of square degrees in a
%         sphere is equal to 4pi x (57.2957795º)² = 41,253 square degrees 
%         (rounded to the nearest square degree). For those who prefer to work in
%         square degrees, it is helpful to remember that the number of square degrees in a
%         sphere contains the digits 1 through 5, with no repeats.
% 
%         Steradians occur virtually anywhere in physics where a flux through a three
%         dimensional surface is involved. For example, the ubiquitous factors of 4pi that
%         keep popping up in formulas derived in electromagnetics really just represent the
%         scaling, or normalizing, of whatever is being described to the angular area
%         subtended by a sphere. Not surprisingly, steradians find heavy use in antenna
%         engineering to characterize such properties as the 'directivity' of an antenna
%         relative to an 'isotropic' radiator (one that radiates uniformly in all directions
%         through the surface of an imaginary sphere)"
%
%
%      Further Notes to myself:
%      The steradians or square radians unit is sr
%      1 radian  =  180º/pi radians  =  57.29577951º
%
%      single steradian:
%      1 radian² (sr)  =  steradian  =  (57.29577951º)²  =  3282.80635 deg²
%
%      amount of steradians in a unit sphere:
%      4pi(3282.80635 deg²)  =  41235 deg² 
%
%
%      William J. Blanch  Lockheed Martin Space and Strategic Missiles    July 16, 2003 
%
% Modified to be a function and allow for user to select items from
% dropdown menu
% Vipul Lugade, PhD
% President, Control One LLC
% https://www.matlabgeeks.com
% Dec 11, 2018
format long g
warning off
%SteRadian Radian Figure object
srrf = figure('Color','k','DoubleBuffer','on','Renderer','opengl',...
              'Name','Steradians (square radians) Demonstration','NumberTitle','off');
          
%SteRadian Radian Axes object
axes('CameraPosition',[4.13142 5.9003 8.66025],'CameraUpVector',[0 1 0],...
            'CameraTarget',[0 0 0],'CameraViewAngle',15.6713,'XLim',[-1 1],...
            'YLim',[-1 1],'ZLim',[-1 1],'Position',[0.25 0.11 0.775 0.815],...
            'NextPlot','add','Parent',srrf,'Visible','off');
        
% plot sphere
[al1, be1, ga1] = plotSphere;
plotLines(al1, be1, ga1);
%set cell array of steradian value multiple of pi, for popup
%each slit/step is kept at pi/8 steradians
srcell = {'1/8','1/4','3/8','1/2','5/8','3/4','7/8','1',...
          '9/8','5/4','11/8','3/2','13/8','7/4','15/8','2',...
          '17/8','9/4','19/8','5/2','21/8','11/4','23/8','3',...
          '25/8','13/4','27/8','7/2','29/8','15/4','31/8','4'};
      
%create the string list that will populate the popup
srlist = char(srcell);
%SteRadian Radian List (popup) object
steDropdown = uicontrol('Style','popup','String',srlist,...
    'Position',[20 150 150 100],'Parent',srrf,'Callback',@plotSteradian,...
    'TooltipString','Steradian Value - Multiple of PI');
    function [al, be, ga] = plotSphere
        %spherical parameters setup
        %longitude
        t1 = 0:0.0625*pi:pi;  %top half of the unit circle
        t2 = -pi+0.0625*pi:0.0625*pi:0;  %bottom half of unit circle - done this way to get 
                                         %the xyz axes along 1 to -1 making origin at (0,0,0)
                                         %angles/longitude is positive counterclockwise
                                         %and negative clockwise.
        %combine both halves to get total azimuth angles matrice                                
        t = [t1,t2];  %Theta -azimuth angle
        %latitude
        p = (-32:2:32)'/32*pi/2;  %Phi -elevation angle
                                  %does not need to go all the way around because that would be
                                  %redundant, also where negatives start/end relative to 
                                  %positives are immaterial, here we start at the South Pole
                                  %calculating through the Equator to the North Pole
                                  %could have started from the North Pole with same results
                                  %except for the direction on the axes which is controlled
                                  %the CameraPosition Axes Property above
        %create the geometry to build the meridians and parallels                          
        sint = sin(t);
        %start azimuth at sphere vertex
        sint(1) = 0; %zero first index of azimuth 
        sint(end) = 0; %zero last index of azimuth
        cosp = cos(p);
        %start elevation at sphere vertex 
        cosp(1) = 0;  %zero first index of elevation
        cosp(end) = 0; %zero last index of elevation
        %Euler Angles - 
        %or more precisely, Cardan Angles (singularity when Rotaion 2 is 90deg)
        %the three rotations are sequential. Whereas for an Euler Angle the first and third
        %rotations are about the same axis giving a singularity when Rotation 2 is 0deg
        al = cosp*cos(t);  %ALpha
        be = cosp*sint;  %BEta
        ga = sin(p)*ones(1,33);  %GAmma
    end
    function wwfl = plotLines(al, be, ga)
        %plot meridian lines - if parallels wanted, would need to use al(i,:), etc., syntax
        %parallels are not necessary for this demonstration
        wwfl = zeros(33,1);
        
        for i = 1:33  
            wwfl(i) = line(al(:,i),be(:,i),ga(:,i),'Color','w');  %plot white wireframe sphere
        end
    end
    function plotSteradian(hObject, event)
        srv = get(hObject,'Value');  %Square Radian Value - get index of the popup value chosen
        % clear surfaces
        handles = findobj(gcf, 'type', 'surface');       
        delete(handles);
        
        %Square Radian
        sr = srv+1;  %since zero steradians cannot be viewed it is not included
                     %so the first one that can be viewed is to the second plane
                     %computed, hence the plus one
        % plot wireframe 
        % [al, be, ga] = plotSphere;
        handles = findobj(gcf, 'type', 'line');       
        delete(handles);
        [al, be, ga] = plotSphere;
        wwfl = plotLines(al, be, ga);
        
        for plane = 1:sr  %loop thru the number of planes chosen in the popup
            %create surface objects that will be swept during animation giving
            %the impression of the FOV increasing or an eye opening
            if plane ~= 1
                xs = cat(2,al(:,plane-1),al(:,plane));  %X Surface
                ys = cat(2,be(:,plane-1),be(:,plane));  %Y Surface
                zs = cat(2,ga(:,plane-1),ga(:,plane));  %Z Surface
                %SteRadian Radian Surface object
                srrs = surface(xs,ys,zs);
                set(srrs,'FaceColor','r','EdgeColor','none');
            end
            %include this next if statement to retain a white border
            %around any chosen Field of View deleting all white wireframe lines within
            %also keeps the last wireframe line in if a sweep of 4pi steradians
            %is chosen...without the line the end object looks like a circle
            %rather than a sphere
            
            if plane > 2  
                delete(wwfl(plane-1))
            end
            pause(0.1)  %to show animation - using this rather than drawnow
                         %to have more control over the speed of the animation
        end
    end
end