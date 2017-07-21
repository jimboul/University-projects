package com.unipi.alexnikas.matheducation;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.Toast;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

public class MainActivity extends AppCompatActivity {

    private String role, password, typedUsername, typedPassword;
    public EditText editText, editText1;
    Intent intent, intent1;
    String username;
    private ImageButton helpBtnLogin;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        editText = (EditText) findViewById(R.id.titleField);
        editText1 = (EditText) findViewById(R.id.descField);
        helpBtnLogin = (ImageButton) findViewById(R.id.helpBtnLogin);
        intent = new Intent(this, Welcome.class);
        intent1 = new Intent(this, ProfessorActivity.class);

    }

    //Button click
    public void login(View view) {


        final Context context = getApplicationContext();
        Toast toast1 = Toast.makeText(context, "Connecting...", Toast.LENGTH_SHORT);
        toast1.show();
        typedUsername = editText.getText().toString();
        typedPassword = editText1.getText().toString();
        DatabaseReference rootRef = FirebaseDatabase.getInstance().getReference();
        rootRef.addListenerForSingleValueEvent(new ValueEventListener() {

            @Override
            public void onDataChange(DataSnapshot snapshot) {

                //Check Credentials
                if (typedUsername != null && snapshot.child("users").hasChild(typedUsername)) {

                    password = snapshot.child("users").child(typedUsername).child("password").getValue().toString();
                    role = snapshot.child("users").child(typedUsername).child("role").getValue().toString();

                    if (password.equals(typedPassword)) {
                        if (role.equals("student")){

                            Toast toast = Toast.makeText(context, "Success!", Toast.LENGTH_SHORT);
                            toast.show();
                            intent.putExtra("username", typedUsername);
                            //go to Welcome
                            startActivity(intent);
                        }
                        else if (role.equals("professor")){

                            Toast toast = Toast.makeText(context, "Success!", Toast.LENGTH_SHORT);
                            toast.show();
                            intent1.putExtra("username", typedUsername);
                            //go to Welcome
                            startActivity(intent1);
                        }
                        //go to teacher menu

                    }
                    else {
                        Toast toast = Toast.makeText(context, "Wrong password!", Toast.LENGTH_LONG);
                        toast.show();
                    }
                }
                else {
                    Toast toast = Toast.makeText(context, "User not found!", Toast.LENGTH_LONG);
                    toast.show();
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
    }

    public void help (View view) {
        Toast.makeText(getApplicationContext(), "Please enter your username and password. Contact administrator to reset password.", Toast.LENGTH_LONG).show();
    }
}
