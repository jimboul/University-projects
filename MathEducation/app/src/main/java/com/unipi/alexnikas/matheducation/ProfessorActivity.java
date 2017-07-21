package com.unipi.alexnikas.matheducation;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Toast;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

public class ProfessorActivity extends AppCompatActivity {

    private double grade1, grade2, grade3, grade4, grade5, grade6, total1, total2;
    private String editTest;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_professor);
    }

    public void showStats (View view){
        Intent intent = new Intent(this, Statistics.class);
        startActivity(intent);
    }

    public void showGrades (View view){
        DatabaseReference rootRef = FirebaseDatabase.getInstance().getReference();
        rootRef.addListenerForSingleValueEvent(new ValueEventListener() {

            @Override
            public void onDataChange(DataSnapshot snapshot) {

                //Check Credentials
                grade1 = Double.parseDouble(snapshot.child("users").child("anikas").child("statistics").child("test1_result").getValue().toString());
                grade2 = Double.parseDouble(snapshot.child("users").child("anikas").child("statistics").child("test2_result").getValue().toString());
                grade3 = Double.parseDouble(snapshot.child("users").child("anikas").child("statistics").child("test3_result").getValue().toString());
                grade4 = Double.parseDouble(snapshot.child("users").child("dimitrisb").child("statistics").child("test1_result").getValue().toString());
                grade5 = Double.parseDouble(snapshot.child("users").child("dimitrisb").child("statistics").child("test2_result").getValue().toString());
                grade6 = Double.parseDouble(snapshot.child("users").child("dimitrisb").child("statistics").child("test3_result").getValue().toString());
                System.out.println(grade1 + " " + grade2 + " " +grade3 + " " +grade4 + " " +grade5 + " " +grade6);
                total1 = (grade1 + grade2 + grade3)/3.0;
                total2 = (grade4 + grade5 + grade6)/3.0;
                total1 = Math.round(total1*100)/100.0d;
                total2 = Math.round(total2*100)/100.0d;
                Toast.makeText(getApplicationContext(), "anikas total grades:" + total1 + "%"
                        + " dimitrisb total grades: " + total2 + "%", Toast.LENGTH_LONG).show();

            }
            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });

    }

    public void test1 (View view){
        editTest = "test1";
        Intent intent = new Intent(this, EditTest.class);
        intent.putExtra("editTest", editTest);
        startActivity(intent);
    }
    public void test2 (View view){
        editTest = "test2";
        Intent intent = new Intent(this, EditTest.class);
        intent.putExtra("editTest", editTest);
        startActivity(intent);
    }
    public void test3 (View view){
        editTest = "test3";
        Intent intent = new Intent(this, EditTest.class);
        intent.putExtra("editTest", editTest);
        startActivity(intent);
    }
}
