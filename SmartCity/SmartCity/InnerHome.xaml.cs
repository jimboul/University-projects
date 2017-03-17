using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace SmartCity
{
    /// <summary>
    /// Interaction logic for InnerHome.xaml
    /// </summary>
    public partial class InnerHome : Window
    {
        public InnerHome()
        {
            InitializeComponent();
        }

        private void switchon_Click(object sender, RoutedEventArgs e)
        {
            Uri uri = new Uri("img/Living-RoomDark.jpg", UriKind.Relative);
            BitmapImage img = new BitmapImage(uri);
            bg.Background = new ImageBrush(img);
            var brush = new ImageBrush();
            switchon.Visibility = System.Windows.Visibility.Hidden;
            switchoff.Visibility = System.Windows.Visibility.Visible;
        }
        private void switchoff_Click(object sender, RoutedEventArgs e)
        {
            Uri uri = new Uri("img/Living-Room.jpg", UriKind.Relative);
            BitmapImage img = new BitmapImage(uri);
            bg.Background = new ImageBrush(img);
            var brush = new ImageBrush();
            switchon.Visibility = System.Windows.Visibility.Visible;
            switchoff.Visibility = System.Windows.Visibility.Hidden;
        }
        private void tvcontroler(object sender, RoutedEventArgs e)
        {
            tvc.Visibility = Visibility.Visible;
            Play.Visibility = Visibility.Visible;
            Pause.Visibility = Visibility.Visible;
            Stop.Visibility = Visibility.Visible;
        }

        private void Play_Click(object sender, RoutedEventArgs e)
        {
            mediaElement.Visibility = Visibility.Visible;
            mediaElement.Play();
        }

        private void Stop_Click(object sender, RoutedEventArgs e)
        {
            mediaElement.Stop();
            tvc.Visibility = Visibility.Hidden;
            Play.Visibility = Visibility.Hidden;
            Pause.Visibility = Visibility.Hidden;
            Stop.Visibility = Visibility.Hidden;
            mediaElement.Visibility = Visibility.Hidden;
        }

        private void Pause_Click(object sender, RoutedEventArgs e)
        {
            mediaElement.Pause();
        }

        private void kitchen_Click(object sender, RoutedEventArgs e)
        {
            Kitchen k = new Kitchen();
            k.Show();
            this.Hide(); 
        }

        private void thermostat_Click(object sender, RoutedEventArgs e)
        {
            t.Visibility = Visibility.Visible;
            slider.Visibility = Visibility.Visible;
            label.Visibility = Visibility.Visible;
            label1.Visibility = Visibility.Visible;
            label2.Visibility = Visibility.Visible;
            textBox.Visibility = Visibility.Visible;
            Apply.Visibility = Visibility.Visible;
        }
        private void temperature(object sender, RoutedEventArgs e)
        {
            t.Visibility = Visibility.Hidden;
            slider.Visibility = Visibility.Hidden;
            label.Visibility = Visibility.Hidden;
            label1.Visibility = Visibility.Hidden;
            label2.Visibility = Visibility.Hidden;
            textBox.Visibility = Visibility.Hidden;
            Apply.Visibility = Visibility.Hidden;
            MessageBox.Show("Temperature level: " + textBox.Text + " °C");
        }

        private void back_Click(object sender, RoutedEventArgs e)
        {
            SmartHome smarthome = new SmartHome();
            smarthome.Show();
            this.Hide();
        }

        private void button2_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show(button2.ToolTip.ToString());
        }
    }
}
