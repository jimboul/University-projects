   M S B A M L   `   `   `  ����D  @SmartCity, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null%clr-namespace:SmartCity	SmartCity  5   	       SmartCity.InnerHome   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   )localclr-namespace:SmartCity     5   	   c _Microsoft.Expression.Drawing, Version=4.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35=ed4http://schemas.microsoft.com/expression/2010/drawing  5   	     � Title$  	InnerHome��5	   	   $	��500��6   $	��700��6(   $	��500��64   $	��700��6D    � WindowStartupLocation$ CenterScreen=�6S    � 	Resources 5
         MyButtonStyle �� 
TargetType �� Property �� Value �� 
TargetType ��Name �� Padding	 �� CornerRadius
 �� Triggers P� Property P� Value �� 
TargetName��%  &	        �� 5   
   " ��6&   .�5      ��  �@�OverridesDefaultStyle . 66   �� 5       � ��$ 5q�6'   �� 5       � �� 5      �� 5      " ��6&   .R�5      �� $ border��6!   $��0q�5      $	 4,2q�5      
�������$	 3��5      #��z��5      ._�5      �� $��Center=�6/   $��Center=�6L   5      
 5      P� 5       �@J�IsMouseOver . . �5   "   �� $ border��6)    � ��
 �   �6T   5      5      5       5!      5"      .��5#      � -   5         �Name$ bg��5#      $
��Auto��6   $
��Auto��6%   ��5$   
   �� 5%       �� ImageSource$ img/Living-Room.jpg��6   .+�5'   
   r� -   5         r�Name$ mediaElement��5'      $
��Left=�6-   $��55��6H   $	��Top=�6T   $��81��6l   $��293,235,0,0q�6w    J� RenderTransformOrigin$ 0.5,0.5&�6�    r� LoadedBehavior$ Manual=�6�    r� Source$_ YC:\Users\Dimitris\Documents\Visual Studio 2015\Projects\SmartCity\SmartCity\img\video.avi?�6�   z�5(      V� 5)      .~�5*      �� �� 5+      �� 5,       �� Angle$ -4.498Q�6&   T� 5-      5.      50      �� 51   
   -   5         ��Name$ switchon��51      #��[  6#   $�� ��6J   $
��Left=�6U   $��
76,154,0,0q�6p   $��0q�6�   $	��Top=�6�   $��20��6�   $��22��6�   $y�Visible=�6�   ��52      �� 53      $ img/on_switcher.png��6   55      �� 56   
   -   5        $ 	switchoff��56      #��[  6$   $�� ��6K   $
��Left=�6V   $��
76,154,0,0q�6q   $	��Top=�6�   $��20��6�   $��22��6�   $y�Hidden=�6�   ��57      �� 58      $ img/off_switcher.png��6   5:      �� 5;   
   -   5         ��Name$ control��5;      $
��Left=�6!    � Cursor$
 Hand��6<   $��28��6l   $��347,314,0,0q�6x   $��img/control.png��6�   $
��Fill=�6�   $	��Top=�6�   $��46��6�   $ 0.5,0.5&�6�   z�5<      V� 5=      .~�5>      �� �� 5?      �� 5@      $ 6.805Q�6&   T� 5A      5B      5D      �� 5F   
   -   5         ��Name$	 tvc��5F      ���	#FF202027$	��116��62   $��238,0,0,100q�6?   
���   �$��Bottom=�6c   $
��Left=�6~   $��41��6�   $y�Hidden=�6�   �� 5G   
   -   5        $
 Play��5G      $�� ��6   #��[  6*   $
 Hand��6Q    � ToolTip$ Open TV��6_   $
��Left=�6q   $��244,0,0,181q�6�   $��Bottom=�6�   $��30��6�   $��30��6�   $y�Hidden=�6�   ��5H      �� 5I      $ img/play.png��6   5K      �� 5L   
   -   5        $ Pause��5L      $�� ��6    $
 Hand��6+   #��[  69   $ Pause TV��6`   $
��Left=�6s   $��244,293,0,0q�6�   $	��Top=�6�   $��30��6�   $��30��6�   $y�Hidden=�6�   ��5M      �� 5N      $ img/pause.png��6   5P      �� 5Q   
   -	   5        $
 Stop��5Q      $�� ��6   $
 Hand��6*   #��[  68   $
��Left=�6_   $��244,328,0,0q�6z   $ Close TV��6�   $	��Top=�6�   $��30��6�   $��34��6�   $y�Hidden=�6�   ��5R      �� 5S      $ img/stop.png��6    j� Stretch$ UniformToFill=�68   5U      �� 5V   
   -
   5        $ kitchenb��5V      #��[  6#   $
 Hand��6J   $
��Left=�6X   $��
10,100,0,0q�6s   $	��Top=�6�   $��58��6�   $	��269��6�   ��5W      �� 5X      5Z      �� 5[   
   -   5        $��t��5[   %   ���	#FFCBCBCB$
��Left=�6.   $��136,192,0,141q�6I   
���   �$	��174��6o   $y�Hidden=�6{   �� 5\   
   -   5        $ 
thermostat��5\      $
 Hand��6%   $ Edit Temperature��63   #��[  6N   $�� ��6u   $
��Left=�6�   $��
73,217,0,0q�6�   $	��Top=�6�   $��33��6�   $��27��6�   ��5]      �� 5^      $ img/thermostat.png��6   5`      �� 5a   
   -   5         ��Name$ slider��5a       � Maximum$ 30Q�6!    � Minimum$ 10Q�6.    � Value$ 20Q�6;    �� IsSnapToTickEnabled .   �� TickPlacement$  BottomRight=�6a   ! �� TickFrequency$! 1Q�6}   $
��Left=�6�   $��138,224.991,0,0q�6�   $	��Top=�6�   $	��167��6�   $��17��6�   $y�Hidden=�6�   A� 5b   
   -   5        $��Apply��5b   #   ���	#FFF4F4F5$
��Left=�60   $��187,0,0,144q�6K   
���   �$��69��6o   $��46��6z   $��Bottom=�6�   $y�Hidden=�6�   �� 5c   
   -   5        " ��Name$" label��5c      $��Select Temperature��6   $
��Left=�6<   $��165.996,196.997,0,0q�6W   $	��Top=�6t   $y�Hidden=�6�   �� 5d   
   -   5        $" label1��5d      $��Apply��6    $
��Left=�60   $��201,0,0,155q�6K   $��Bottom=�6`   $y�Hidden=�6{   �� 5e   
   -   5        # ��Name$# textBox��5e      $
��Left=�6#   $��41��6>   $��188,234,0,0q�6J   $ �� TextWrapping$
$ Wrap=�6_   $	��Top=�6s   $��55��6�   $��Right=�6  % �� TextAlignment$% Right=�63  
���   �$��Times New Roman)�6s  $��40(�6�  $
��Bold"�6�  $ 0.509,0.646&�6�  {�.  $y�Hidden=�6  & �� SelectionBrush& 6�   Z� ��6�   Z� ��6�   �� ' �� ElementName$' slider��( �� Path$( Value�) �� UpdateSourceTrigger$) PropertyChanged=���6J  Z� * �� TextDecorations* 6�  Z� 6  �� 5f   
   -   5        $" label2��5f      $	��°C��6    $
��Left=�6-   $��235,232,0,0q�6H   $	��Top=�6]   ���	#FF212020$��14(�6�   $
��Bold"�6�   $y�Hidden=�6�   �� 5g   
   -   5        $
 back��5g      $�� ��6   #��[  6*   $ Go Back��6Q   $
��Left=�6c   $��649,420,0,0q�6~   $	��Top=�6�   $��37��6�   $��43��6�   ��5h      �� 5i      $ img/back.png��6   5k      �� 5l   
   -   5        $ button2��5l      $�� ��6"   $
 Hand��6-   $� �Get the TV Controller to turn on your Smart TV and to turn it off. You can switch on/off the lights from the switcher next the door. As well as you can modify the temperature of your house by clicking the temperature device locating below the switcher. Click the door to enter your kitchen.��6;   $
��Left=�6h  $��
649,10,0,0q�6�  $	��Top=�6�  $��33��6�  $��32��6�  $��0q�6�  ��5m      �� 5n      $ img/help.png��6   5p      5q      5r      