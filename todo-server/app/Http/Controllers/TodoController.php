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
        $todo = Todo::create($request->input());

        return response()->json($todo, 201);
    }

    public function show($id)
    {
        $todo = Todo::findOrFail($id);

        return response()->json($todo);
    }

    public function update(Request $request, $id)
    {
        $todo = Todo::findOrNew($id)->update($request->input());

        return response()->json([$todo]);
    }

    public function destroy($id)
    {
        $todo = Todo::findOrNew($id)->delete();

        return response()->json([$todo]);
    }
}
