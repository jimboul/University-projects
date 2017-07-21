package com.unipi.alexnikas.matheducation;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.Random;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link TestView.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link TestView#newInstance} factory method to
 * create an instance of this fragment.
 */
public class TestView extends Fragment {
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;
    private TextView question1, question2, question3, question4, question5, question6;
    private EditText answer1, answer2, answer3, answer4, answer5, answer6;
    private String a1, a2, a3, a4, a5, a6;
    private double score = 0;
    private Button submitBtn1;
    private ImageView helpBtnTest;
    private int rand;
    private String username, testSelected;
    DatabaseReference rootRef = FirebaseDatabase.getInstance().getReference();

    private OnFragmentInteractionListener mListener;

    public TestView() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment TestView.
     */
    // TODO: Rename and change types and number of parameters
    public static TestView newInstance(String param1, String param2) {
        TestView fragment = new TestView();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_test_view, container, false);
        question1 = (TextView) view.findViewById(R.id.question1);
        question2 = (TextView) view.findViewById(R.id.question2);
        question3 = (TextView) view.findViewById(R.id.question3);
        question4 = (TextView) view.findViewById(R.id.question4);
        question5 = (TextView) view.findViewById(R.id.question5);
        question6 = (TextView) view.findViewById(R.id.question6);
        answer1 = (EditText) view.findViewById(R.id.answer1);
        answer2 = (EditText) view.findViewById(R.id.answer2);
        answer3 = (EditText) view.findViewById(R.id.answer3);
        answer4 = (EditText) view.findViewById(R.id.answer4);
        answer5 = (EditText) view.findViewById(R.id.answer5);
        answer6 = (EditText) view.findViewById(R.id.answer6);
        submitBtn1 = (Button) view.findViewById(R.id.submitBtn1);
        helpBtnTest = (ImageButton) view.findViewById(R.id.helpBtnTest);
        testSelected = this.getArguments().getString("testSelected");
        username = this.getArguments().getString("username");
        System.out.println("********" + username + " "+ this.getArguments().getString("testSelected"));
        rootRef.addListenerForSingleValueEvent(new ValueEventListener() {

            @Override
            public void onDataChange(DataSnapshot snapshot) {
                if(!testSelected.equals("random")) {
                    question1.setText(snapshot.child("tests").child(testSelected).child("question1").getValue().toString());
                    question2.setText(snapshot.child("tests").child(testSelected).child("question2").getValue().toString());
                    question3.setText(snapshot.child("tests").child(testSelected).child("question3").getValue().toString());
                    question4.setText(snapshot.child("tests").child(testSelected).child("question4").getValue().toString());
                    question5.setText(snapshot.child("tests").child(testSelected).child("question5").getValue().toString());
                    question6.setText(snapshot.child("tests").child(testSelected).child("question6").getValue().toString());
                    a1 = snapshot.child("tests").child(testSelected).child("correct_answer_1").getValue().toString();
                    a2 = snapshot.child("tests").child(testSelected).child("correct_answer_2").getValue().toString();
                    a3 = snapshot.child("tests").child(testSelected).child("correct_answer_3").getValue().toString();
                    a4 = snapshot.child("tests").child(testSelected).child("correct_answer_4").getValue().toString();
                    a5 = snapshot.child("tests").child(testSelected).child("correct_answer_5").getValue().toString();
                    a6 = snapshot.child("tests").child(testSelected).child("correct_answer_6").getValue().toString();
                }
                else{
                    Random r = new Random();
                    rand = r.nextInt((6 - 1) + 1) + 1;
                    question1.setText(snapshot.child("tests").child("test1").child("question" + String.valueOf(rand)).getValue().toString());
                    a1 = snapshot.child("tests").child("test1").child("correct_answer_" + String.valueOf(rand)).getValue().toString();
                    rand = r.nextInt((6 - 1) + 1) + 1;
                    question2.setText(snapshot.child("tests").child("test1").child("question" + String.valueOf(rand)).getValue().toString());
                    a2 = snapshot.child("tests").child("test1").child("correct_answer_" + String.valueOf(rand)).getValue().toString();
                    rand = r.nextInt((6 - 1) + 1) + 1;
                    question3.setText(snapshot.child("tests").child("test2").child("question" + String.valueOf(rand)).getValue().toString());
                    a3 = snapshot.child("tests").child("test2").child("correct_answer_" + String.valueOf(rand)).getValue().toString();
                    rand = r.nextInt((6 - 1) + 1) + 1;
                    question4.setText(snapshot.child("tests").child("test2").child("question" + String.valueOf(rand)).getValue().toString());
                    a4 = snapshot.child("tests").child("test2").child("correct_answer_" + String.valueOf(rand)).getValue().toString();
                    rand = r.nextInt((6 - 1) + 1) + 1;
                    question5.setText(snapshot.child("tests").child("test3").child("question" + String.valueOf(rand)).getValue().toString());
                    a5 = snapshot.child("tests").child("test3").child("correct_answer_" + String.valueOf(rand)).getValue().toString();
                    rand = r.nextInt((6 - 1) + 1) + 1;
                    question6.setText(snapshot.child("tests").child("test3").child("question" + String.valueOf(rand)).getValue().toString());
                    a6 = snapshot.child("tests").child("test3").child("correct_answer_" + String.valueOf(rand)).getValue().toString();
                }
            }
            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
        //  do the proper actions with StorageReferences and DatabaseReferences or whatever...
        // get the right children, fathers, mothers, sisters and the whole family and kill them all!!!!
        // I am back in a minute....
        submitBtn1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                calculateResults();
            }
        });
        helpBtnTest.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Toast.makeText(getContext(), "Please answer the questions and then hit the submit button.", Toast.LENGTH_SHORT).show();
            }
        });
        return view;
    }

    // TODO: Rename method, update argument and hook method into UI event
    public void onButtonPressed(Uri uri) {
        if (mListener != null) {
            mListener.onFragmentInteraction(uri);
        }
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        if (context instanceof OnFragmentInteractionListener) {
            mListener = (OnFragmentInteractionListener) context;
        } else {
            throw new RuntimeException(context.toString()
                    + " must implement OnFragmentInteractionListener");
        }
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }

    /**
     * This interface must be implemented by activities that contain this
     * fragment to allow an interaction in this fragment to be communicated
     * to the activity and potentially other fragments contained in that
     * activity.
     * <p>
     * See the Android Training lesson <a href=
     * "http://developer.android.com/training/basics/fragments/communicating.html"
     * >Communicating with Other Fragments</a> for more information.
     */
    public interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        void onFragmentInteraction(Uri uri);
    }

    private void calculateResults() {
        if (answer1.getText().toString().equals(a1)) {
            score = score + 1;
        }
        if (answer2.getText().toString().equals(a2)) {
            score = score + 1;
        }
        if (answer3.getText().toString().equals(a3)) {
            score = score + 1;
        }
        if (answer4.getText().toString().equals(a4)) {
            score = score + 1;
        }
        if (answer5.getText().toString().equals(a5)) {
            score = score + 1;
        }
        if (answer6.getText().toString().equals(a6)) {
            score = score + 1;
        }
        score = (score / 6) * 100;
        score = Math.round(score*100)/100.0d;
        Toast.makeText(getContext(), "You scored: " + score + "%", Toast.LENGTH_LONG).show();
        setData2(rootRef);
    }

    public void setData2(final DatabaseReference refUpdates){
        refUpdates.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                //DatabaseReference update = refUpdates.push();
                refUpdates.child("users").child(username).child("statistics").child(testSelected + "_result").setValue(score);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
    }
}
