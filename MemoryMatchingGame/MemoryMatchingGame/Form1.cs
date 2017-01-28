using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MemoryMatchingGame
{
    public partial class MemoryMatchingGame : Form
    {

        int attempt_counter = 0; //Δημιουργώ ένα μετρητή προσπαθειών
        int suc_att_c = 0; //Δημιουργώ έναν μετρητή επιτυχημένων προσπαθειών
        public int sec_counter = 45;//Δημιουργώ τον μετρητή για την αντίστροφη μέτρηση μέχρι το τέλος του παιχνιδιού
        int score = 0;//Κρατάει το score του παιχνιδιού
        string result; // Δείχνει το αποτέλεσμα του παιχνιδιού
        Random rand = new Random(); // Διασφαλίζουμε την τυχαιότητα στην κατανομή των καρτών


        public MemoryMatchingGame()
        {
            InitializeComponent();
        }

        private void MemoryMatchingGame_Load(object sender, EventArgs e)
        {
            foreach (PictureBox picbox in table.Controls)
            {
                picbox.Image = Properties.Resources.Cover;
            }
        }

        private void countdown_timer_Tick(object sender, EventArgs e)
        {
            sec_counter--;
            label2.Text = "Time: " + sec_counter + " seconds";
            if (sec_counter == 0)
            {
                countdown_timer.Stop();
                result = "Loser (out of time)";
                //scores.WriteLine(result);
                //scores.WriteLine(score + " points");
                //scores.WriteLine(45 - sec_counter + " sec");
                //scores.WriteLine(attempt_counter + " attempts. " + suc_att_c + " successful and " + (attempt_counter - suc_att_c) + " unsuccessful.");
                //scores.Close();
                //player1.Play();
                MessageBox.Show("Time is over! You lost! You need some more practice!");
                Application.Exit();
                Close();
            }
        }
    }
}
