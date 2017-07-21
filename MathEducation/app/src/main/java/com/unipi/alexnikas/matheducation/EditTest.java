package com.unipi.alexnikas.matheducation;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.EditText;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

public class EditTest extends AppCompatActivity {
    private EditText answer1e, answer2e, answer3e, answer4e, answer5e, answer6e, question1e, question2e, question3e, question4e, question5e, question6e;
    private String editTest;
    DatabaseReference rootRef = FirebaseDatabase.getInstance().getReference();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_test);
        editTest = getIntent().getExtras().getString("editTest");
        answer1e = (EditText) findViewById(R.id.answer1e);
        answer2e = (EditText) findViewById(R.id.answer2e);
        answer3e = (EditText) findViewById(R.id.answer3e);
        answer4e = (EditText) findViewById(R.id.answer4e);
        answer5e = (EditText) findViewById(R.id.answer5e);
        answer6e = (EditText) findViewById(R.id.answer6e);
        question1e = (EditText) findViewById(R.id.question1e);
        question2e = (EditText) findViewById(R.id.question2e);
        question3e = (EditText) findViewById(R.id.question3e);
        question4e = (EditText) findViewById(R.id.question4e);
        question5e = (EditText) findViewById(R.id.question5e);
        question6e = (EditText) findViewById(R.id.question6e);
        rootRef.addListenerForSingleValueEvent(new ValueEventListener() {

            @Override
            public void onDataChange(DataSnapshot snapshot) {

                question1e.setText(snapshot.child("tests").child(editTest).child("question1").getValue().toString());
                question2e.setText(snapshot.child("tests").child(editTest).child("question2").getValue().toString());
                question3e.setText(snapshot.child("tests").child(editTest).child("question3").getValue().toString());
                question4e.setText(snapshot.child("tests").child(editTest).child("question4").getValue().toString());
                question5e.setText(snapshot.child("tests").child(editTest).child("question5").getValue().toString());
                question6e.setText(snapshot.child("tests").child(editTest).child("question6").getValue().toString());
                answer1e.setText(snapshot.child("tests").child(editTest).child("correct_answer_1").getValue().toString());
                answer2e.setText(snapshot.child("tests").child(editTest).child("correct_answer_2").getValue().toString());
                answer3e.setText(snapshot.child("tests").child(editTest).child("correct_answer_3").getValue().toString());
                answer4e.setText(snapshot.child("tests").child(editTest).child("correct_answer_4").getValue().toString());
                answer5e.setText(snapshot.child("tests").child(editTest).child("correct_answer_5").getValue().toString());
                answer6e.setText(snapshot.child("tests").child(editTest).child("correct_answer_6").getValue().toString());
            }
            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
    }

    public void makeChanges(View view){
        setData3(rootRef);
    }

    public void setData3(final DatabaseReference refUpdates){
        refUpdates.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                //DatabaseReference update = refUpdates.push();
                refUpdates.child("tests").child(editTest).child("question1").setValue(question1e.getText().toString());
                refUpdates.child("tests").child(editTest).child("question2").setValue(question2e.getText().toString());
                refUpdates.child("tests").child(editTest).child("question3").setValue(question3e.getText().toString());
                refUpdates.child("tests").child(editTest).child("question4").setValue(question4e.getText().toString());
                refUpdates.child("tests").child(editTest).child("question5").setValue(question5e.getText().toString());
                refUpdates.child("tests").child(editTest).child("question6").setValue(question6e.getText().toString());
                refUpdates.child("tests").child(editTest).child("correct_answer_1").setValue(answer1e.getText().toString());
                refUpdates.child("tests").child(editTest).child("correct_answer_2").setValue(answer2e.getText().toString());
                refUpdates.child("tests").child(editTest).child("correct_answer_3").setValue(answer3e.getText().toString());
                refUpdates.child("tests").child(editTest).child("correct_answer_4").setValue(answer4e.getText().toString());
                refUpdates.child("tests").child(editTest).child("correct_answer_5").setValue(answer5e.getText().toString());
                refUpdates.child("tests").child(editTest).child("correct_answer_6").setValue(answer6e.getText().toString());
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
    }
}
