<?php

namespace App\Http\Controllers;

use App\Traits\ApiResponseTrait;

abstract class BaseApiController extends Controller
{
    use ApiResponseTrait;
}
