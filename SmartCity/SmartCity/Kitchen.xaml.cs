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
    /// Interaction logic for Kitchen.xaml
    /// </summary>
    public partial class Kitchen : Window
    {
        public Kitchen()
        {
            InitializeComponent();
        }

        private void back_Click(object sender, RoutedEventArgs e)
        {
            InnerHome back1 = new InnerHome();
            back1.Show();
            this.Hide();
        }

        private void machine_Click(object sender, RoutedEventArgs e)
        {
            if (jug.Visibility == Visibility.Visible && package.Visibility == Visibility.Visible)
            {
                MessageBox.Show("Please insert some coffee and fill the jug with water");
            }
            else if (jug.Visibility == Visibility.Hidden && package.Visibility == Visibility.Hidden)
            {
                player.Play();
                MessageBox.Show("Your coffee is ready");
                cup.Visibility = Visibility.Visible;
            }
            else
            {
                MessageBox.Show("Please insert some coffee and fill the jug with water");
            }
        }

        private void jug_Click(object sender, RoutedEventArgs e)
        {
            jug.Visibility = Visibility.Hidden;
        }

        private void package_Click(object sender, RoutedEventArgs e)
        {
            package.Visibility = Visibility.Hidden;
        }

        private void cup_Click(object sender, RoutedEventArgs e)
        {
            coffeedrink.Play();
            cup.Visibility = Visibility.Hidden;
        }

        private void button2_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show(button2.ToolTip.ToString());
        }
    }
}
