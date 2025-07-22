<?php

namespace App\Http\Controllers;

use App\Models\Todo;
use Illuminate\Http\Request;

class TodoController extends Controller
{
    public function index()
    {
        $todos = Todo::all();

        return response()->json($todos);
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            "title" => "required|string",
            "email" => "required|string",
        ]);

        $todo = Todo::create($validatedData);

        return response()->json([$todo]);
    }

    public function show($id)
    {
        $todo = Todo::findOrFail($id);

        return response()->json($todo);
    }

    public function update(Request $request, $id)
    {
        $validatedData = $request->validate([
            "title" => "required|string",
            "email" => "required|string",
        ]);

        $todo = Todo::findOrNew($id)->update($validatedData);

        return response()->json([$todo]);
    }

    public function destroy($id)
    {
        $todo = Todo::findOrNew($id)->delete();

        return response()->json([$todo]);
    }
}
