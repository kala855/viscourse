
#include <vtkVersion.h>
#include <vtkSmartPointer.h>
#include <vtkProperty.h>
#include <vtkTable.h>
#include <vtkRenderWindow.h>
#include <vtkRenderWindowInteractor.h>
#include <vtkRenderer.h>
#include <vtkVertexGlyphFilter.h>
#include <vtkContextView.h>
#include <vtkContextScene.h>
#include <vtkPlot.h>
#include <vtkChartXY.h>
#include <vtkAxis.h>
#include <vtkDelimitedTextReader.h>

#define VTK_CREATE(type, name) \
    vtkSmartPointer<type> name = vtkSmartPointer<type>::New()


int main(int argc, char* argv[])
{
  // Verify input arguments
  if(argc != 2)
    {
    std::cout << "Usage: " << argv[0]
              << " Filename(.csv)" << std::endl;
    return EXIT_FAILURE;
    }

  std::string inputFilename = argv[1];


  VTK_CREATE(vtkContextView,view);
  view->GetRenderer()->SetBackground(1.0,1.0,1.0);
  view->GetRenderWindow()->SetSize(400,300);
  VTK_CREATE(vtkChartXY, chart);
  view->GetScene()->AddItem(chart);

  VTK_CREATE(vtkDelimitedTextReader,reader);
  reader->SetFileName(inputFilename.c_str());
  reader->DetectNumericColumnsOn();
  reader->SetFieldDelimiterCharacters(",");
  reader->SetHaveHeaders(true);
  reader->Update();

  vtkTable* table = reader->GetOutput();

  std::cout << "Table has " << table->GetNumberOfRows()
            << " rows." << std::endl;
  std::cout << "Table has " << table->GetNumberOfColumns()
            << " columns." << std::endl;

  for(vtkIdType i = 0; i < table->GetNumberOfRows(); i++)
    {
    std::cout <<"Data:" << (table->GetValue(i,0)).ToDouble()
              <<" Penicillin:" << (table->GetValue(i,1)).ToDouble()
              <<" Streptomycin:" << (table->GetValue(i,2)).ToDouble()
              <<" Neomycin:" << (table->GetValue(i,3)).ToDouble()
              <<" Gram Staining:" << (table->GetValue(i,4)).ToDouble()
              << endl;
    }

  vtkPlot *line = 0;

  VTK_CREATE(vtkAxis, ejey);

  ejey = chart->GetAxis(vtkAxis::LEFT);
  ejey->SetLogScale(false);
  ejey->Update();


  int i=0, j=0;
  //for (i = 0; i < table->GetNumberOfRows(); i++) {
      //for (j = 1; j < table->GetNumberOfColumns()-1; j++) {
          line = chart->AddPlot(vtkChart::BAR);
          line->SetInputData(table,1,0);
          line->SetColor(10,50,25,255);
     // }

//  }

  view->GetRenderWindow()->SetMultiSamples(0);
  view->GetInteractor()->Initialize();
  view->GetInteractor()->Start();

  return EXIT_SUCCESS;
}