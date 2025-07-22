<?php

use App\Http\Controllers\TodoController;
use Illuminate\Support\Facades\Route;

Route::get("/todos", [TodoController::class, "index"]);
Route::get("/todos/{id}", [TodoController::class, "show"]);
Route::post("/todos/", [TodoController::class, "store"]);
Route::put("/todos/{id}", [TodoController::class, "update"]);
Route::delete("/books/{id}", [TodoController::class, "destroy"]);
